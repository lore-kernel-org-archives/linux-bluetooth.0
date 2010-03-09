Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Mar 2010 23:38:41 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Felix Huber <felix.huber@schyf.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Phonebook functions for BlueZ
Message-ID: <20100309033841.GA21210@jh-x301>
References: <4B8A3EEA.3030901@schyf.de>
 <20100301192050.GA25876@jh-x301>
 <1267982102.7714.87.camel@rb-l1.nos.office>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1267982102.7714.87.camel@rb-l1.nos.office>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felix,

On Sun, Mar 07, 2010, Felix Huber wrote:
> > > +int get_ATtype(const char *buf, int *offset)
> > > +{
> > > +	const char *ATquery = "=?", *ATcheck ="?", *ATset = "=";
> > 
> > We usually don't use capital letters in any variable or function names.
> > Pre-processor defines are an exception. So use something like
> > get_at_type, at_query, etc.
> Well usually, but since AT in this case is a proper name, I found it
> very confusing to read it like the prepostion "at" or even a spelled-out
> @-sign. I added an underscore for better indication of what it is.

I understand your point, but this is simply the way the coding style is.
Even if I would accept it (which I wont) it'd ultimately get rejected by
Marcel.

> > > +char *fso_categories[NUM_CATEGORIES] = {"contacts", "emergency", "fixed", "dialed", "received", "missed", "own"};
> > > +char *gsm_categories[NUM_CATEGORIES] = {"\"SM\"",   "\"EN\"",    "\"FD\"","\"DC\"", "\"RC\"",   "\"MC\"", "\"ON\""};
> 
> > Probably you could split these to fit within 80 columns.
> Done, but now we loose the one-to-one correspondance.

Ah, I missed that relationship between the two lists. If this one-to-one
correspondance is so important, why not create a simple struct with two
const char* members and have just one list? Then you'd have the
definition as something like:

struct category categories[] = {
	{ "contacts",	"\"SM\"" },
	{ "emergency",	"\"EN\"" },
	...
	{ NULL, NULL }
};

> > > +		if (!strcmp(phonebooks[i], category))
> > 
> > The convention has usually been to use == 0 in the case of strcmp for
> > readability.
> > 
> Not quite, as it seems: I looked at the other files and they also used
> the ! (including one commited by you :) ). So I chose the logical not,
> which also frees one from having to handle 0 vs. NULL.

BlueZ is unfortunately full of many such inconsistencies in the code:

jh@jh-x301~/src/bluez{master}$ git grep '!.*cmp('|wc -l
183
jh@jh-x301~/src/bluez{master}$ git grep 'cmp(.*== 0'|wc -l
111

But you're right in that the '!' form seems to be more frequent (those
regexps might have some false positives though). IMHO since the test in
question is a positive one ("if A is equal to B, then...") the negation
sign in the statement is at least initially counterintuitive. You might
also want to consider using g_str_equal which is quite popular througout
the code base (I got 102 hits) or g_strcmp0 in the case that there is
risk that one of the inputs could be NULL.

> > > +	if ((vc = find_vc_with_status(CALL_STATUS_ACTIVE))) {
> > > +	} else if ((vc = find_vc_with_status(CALL_STATUS_DIALING))) {
> > > +	} else if ((vc = find_vc_with_status(CALL_STATUS_INCOMING))) {
> > > +	}
> > 
> > The purpose of this construction isn't imediately clear imo. Wouldn't
> > something like doing specific NULL checks after each find() call be more
> > readable? I.e.
> > 
> Well, to me it was clear that these are nested calls until a valid vc is
> found. But anyway, I copied this from telephony-ofono and tried to stay
> close to the original code for better re-recognition. So either both
> should be changed or none but not be strict only on new code, since this
> makes copy-and-paste ineffective.

Ok, so let's just leave it as it is for now.

> > > +#if 0
> > > +	if (!strncmp(number, "*31#", 4)) {
> > > +		number += 4;
> > > +		clir = "enabled";
> > > +	} else if (!strncmp(number, "#31#", 4)) {
> > > +		number += 4;
> > > +		clir =  "disabled";
> > > +	} else
> > > +		clir = "default";
> > > +#endif
> > 
> > Is this really code that you think can be enabled later? If not I'd just
> > remove it instead of having it commented out.
> > 
> Yes, it is needed. My car kit (and maybe others) have a menu to activate
> this, but the current FSO API cannot handle it yet. Since this driver
> needs to be update anyhow once the opimd is final, I left it in so it
> cannot get forgotten to be reenabled.

Alright, so it's fine then.

> > > +	if (cmd) {
> > > +		err = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
> > > +					FSO_GSMC_INTERFACE,
> > > +					cmd, NULL, NULL,
> > > +					DBUS_TYPE_INT32, &vc->call_index,
> > > +					DBUS_TYPE_INVALID);
> > > +	}
> > > +	if (err < 0)
> > > +		telephony_key_press_rsp(telephony_device, CME_ERROR_AG_FAILURE);
> > > +        else
> > > +		telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
> > 
> > Shouldn't it be an error if cmd is NULL? In general doing
> > initializations upon declaration, especially for error variables, should
> > be avoided. Would e.g. having a final "else err = -EINVAL" at the end of
> > the else/else if statement make sense (which would allow removing the
> > initialzation of err to 0?
> No no, beware! It can happen that the other side of the phone call just hung up
> before the key press or that a nasty user presses a key when nothing is going on.
> In this case, the press is silenty ignored instead of confusing some headsets with an
> unexpected failure.

Right. Do fix the braces usage for the single-line though. You might
want to consider getting rid of the act and rel variables completely and
just assign directly the string to cmd (or if it bothers you to have the
same string twice for ACTIVE and DIALING create #defines for them.

> > > +static void retrieve_phonebook_reply(DBusPendingCall *call, void *user_data)
> > > +{
> > > +	DBusError err;
> > > +	DBusMessage *reply;
> > > +	DBusMessageIter iter, array;
> > > +	int ret = 0;
> > 
> > Instead of initializing ret upon declaration (and btw, we use "err"
> > instead of "ret" usually) you could set it to 0 right before the done
> > label.
> Again, I checked with the other telephony files: they use ret for their
> codes and err for DBus error. So I stayed consistent with the names.

I guess this is yet another example of BlueZ internal inconsistency
then. However, I know that Marcel prefers err and we should strive to
use it in all new code.

> > > +	gstr = g_string_new("(");
> > > +	for (i=0; i< n_s; i++) {
> > 
> > Missing spaces before and after '=', before '<'. Can you come up with a
> > more descriptive name for the n_s variable please?
> What about num_strings? This is my feeling only, since I copied this
> from the DBus tutorial.

num_strings is certianly more descriptive than the current name and I
can't come up with anything better right now, so let's just go with it.

> > > +		sscanf(readindex, "%d,%d", &phonebook_info.first, &phonebook_info.last);
> > > +		if (phonebook_info.first == -1)
> > > +			break;
> > 
> > Probably you'd also want to check for sscanf return value (i.e. == 2).
> > Maybe that's the only thing you should check for and not try to
> > initialize these variables here since you already do that in the
> > beginning of telephony-fso.c where you define the phonebook_info struct?
> Nope, the arguments are optional and both 0,1 or two conversions can
> happen, so the return of sscanf serves nothing in this case.

Ok.

> > > +	if (g_str_equal(property, "direction")) {
> > > +		dbus_message_iter_get_basic(&sub, &direction);
> > > +	} else if (g_str_equal(property, "peer")) {
> > > +		dbus_message_iter_get_basic(&sub, &peer);
> > > +		vc->number = g_strdup(peer);
> > > +	} else if (g_str_equal(property, "reason")) {
> > > +		dbus_message_iter_get_basic(&sub, &reason);
> > > +	} else if (g_str_equal(property, "auxstatus")) {
> > > +		dbus_message_iter_get_basic(&sub, &auxstatus);
> > > +	} else if (g_str_equal(property, "line")) {
> > > +		dbus_message_iter_get_basic(&sub, &line);
> > > +	}
> > 
> > No braces for one-line scopes.
> Well, here we have a conflict: The kernel style guide says that if one
> of the blocks has braces the other one should also have, even if it is a
> single line.

Yesh, I noticed the same thing when checking the kernel coding style
guidelines. Most of BlueZ code is in conflict with the kernel coding
style in this respect, so I think we'd need some comment from Marcel on
what exactly he wants the BlueZ style to be (might be that I've already
discussed this a long time ago with him but I can't remember the outcome
right now).

> > > +	/* ARRAY -> ENTRY -> VARIANT*/
> > 
> > Space before */
> Done, copy and paste telephony-ofono.c -> should be fixed there too.

Alright. I just pushed a fix for telephony-ofono.c.

> > > --- a/audio/telephony.h
> > > +++ b/audio/telephony.h
> > > @@ -127,6 +127,12 @@ typedef enum {
> > >  	CME_ERROR_NETWORK_NOT_ALLOWED	= 32,
> > >  } cme_error_t;
> > >  
> > > +/* AT command types */
> > > +#define ATNONE  0
> > > +#define ATQUERY 1
> > > +#define ATCHECK 2
> > > +#define ATSET   3
> 
> > These should probably be an enum and have some namespacing (e.g.
> > AT_TYPE_).
> Again, in order to be consistent with the existing codes, I looked at
> what the other files do. I adopted the use of the Call parameters, like
> CALL_STATUS_ACTIVE. These are all #defines

Right. So AT_* should be enough then (as you've done).

Johan
