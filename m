Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Mar 2010 16:20:50 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Felix Huber <Felix.Huber@schyf.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Phonebook functions for BlueZ
Message-ID: <20100301192050.GA25876@jh-x301>
References: <4B8A3EEA.3030901@schyf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B8A3EEA.3030901@schyf.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felix,

On Sun, Feb 28, 2010, Felix Huber wrote:
> I have analyzed the data traffic of my car handsfree set and implemented
> the functions for the phonebook retrieval via the CPBR and CPBS
> commands. In addition, I added a telephony driver for the FSO middleware
> with which I tested the new functions using a Parrot CK3100 car kit and
> a Jabra ear plug using version 4.61 of BlueZ. The other telephony
> drivers just have empty functions that reject the new commands in order
> not to break the APIs.
> 
> Attached is the patch file for the git repository.

Thanks for this contribution! In general the patch looks quite ok,
however before pushing this upstream there are a some coding style
issues that'd need to be fixed:

> +int get_ATtype(const char *buf, int *offset)
> +{
> +	const char *ATquery = "=?", *ATcheck ="?", *ATset = "=";

We usually don't use capital letters in any variable or function names.
Pre-processor defines are an exception. So use something like
get_at_type, at_query, etc. Also, since get_ATtype is only used within
headset.c you have to declare it static.

> +	if (!strncmp(buf, ATquery, 2)) {
> +		*offset = 2;
> +		return (ATQUERY);

No () around the value given to return;

> +	} else if (!strncmp(buf, ATcheck, 1)) {
> +		*offset = 1;
> +		return (ATCHECK);
> +	} else if (!strncmp(buf, ATset, 1)) {
> +		*offset = 1;
> +		return (ATSET);
> +	} else {
> +		*offset = 0;
> +		return (ATNONE);
> +	}
> +}
> +
> +

There shouldn't at any point be the need to have more than one empty
line in the code, so please remove the other.

> +int telephony_phonebook_storage_ind(void *telephony_device, const char *storagelist)

This line looks like it's longer than 80 columns. Please split it to
two.

> +	headset_send(hs, "\r\n+CPBS: %s \r\n", storagelist);

Why is there a space before the "\r\n"?

> +	int ATtype, offset;

Again the capital letter thing.

> +	if (strlen(buf) < 8) {
> +		return -EINVAL;
> +	}

No braces for single-line scopes.

> +	ATtype = get_ATtype(&buf[7], &offset);

No capital letters.

> +	if (strlen(buf) < 8) {
> +		return -EINVAL;
> +	}

No braces.

> +	ATtype = get_ATtype(&buf[7], &offset);
> +	telephony_phonebook_read_req(device, &buf[7+offset], ATtype);
> +
> +	return 0;
> +}
> +
> +

Unnecessary extra empty line.

> +void telephony_phonebook_read_req(void *telephony_device, const char *readindex, int ATtype)

Looks like a > 80 column line.

> +void telephony_phonebook_storage_req(void *telephony_device, const char *readindex, int ATtype)

Same issue.

> +{
> +	telephony_phonebook_storage_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
> +}
> +
> +

Extra empty line again.

> +char *fso_categories[NUM_CATEGORIES] = {"contacts", "emergency", "fixed", "dialed", "received", "missed", "own"};
> +char *gsm_categories[NUM_CATEGORIES] = {"\"SM\"",   "\"EN\"",    "\"FD\"","\"DC\"", "\"RC\"",   "\"MC\"", "\"ON\""};

Probably you could split these to fit within 80 columns.

> +static struct {
> +	uint8_t status;         // act  'GSM'
> +	uint32_t cell_id;       // cid  '51FD'
> +	uint32_t operator_code; // code '26203'
> +	uint16_t lac;           // lac  '233b' 

We don't use C++ style comments. So please change to /* .. */. Also,
there's an extra space at the end of the "lac" line.

> +} net = {
> +	.status = NETWORK_REG_STATUS_UNREGISTERED,
> +	.cell_id = 0,
> +	.operator_code = 0,
> +	.lac = 0,
> +	.mode = NULL,
> +	.operator_name = NULL,
> +	.registration = NULL,
> +	.signals_bar = 0,
> +};
> +
> +

Extra empty line.

> +static void vc_free(struct voice_call *vc)
> +{
> +	if (!vc)
> +		return;
> +	g_free(vc->number);
> +	g_free(vc);
> +}
> +
> +

Extra empty line.

> +static int find_category(char **phonebooks, const char *category)
> +{
> +	int i;
> +	for (i=0; i < NUM_CATEGORIES; i++) {

Space before and after '='.

> +		if (!strcmp(phonebooks[i], category))

The convention has usually been to use == 0 in the case of strcmp for
readability.

> +			return i;
> +	}
> +	return -1;
> +
> +}

Why the empty line after the return statement? I'd put it after the
for-loop for consistency with the rest of the code base.

> +
> +

Extra empty line.

> +static int send_method_call(const char *dest, const char *path,
> +				const char *interface, const char *method,
> +				DBusPendingCallNotifyFunction cb,
> +				void *user_data, int type, ...)

Since this and many other functions are shared with (or actually copied
from) telephony-maemo.c would it make sense to put them to some shared
c-file (it's fine if this is a separate commit later).

> +	if ((vc = find_vc_with_status(CALL_STATUS_ACTIVE))) {
> +	} else if ((vc = find_vc_with_status(CALL_STATUS_DIALING))) {
> +	} else if ((vc = find_vc_with_status(CALL_STATUS_INCOMING))) {
> +	}

The purpose of this construction isn't imediately clear imo. Wouldn't
something like doing specific NULL checks after each find() call be more
readable? I.e.

vc = find(...);
if (vc == NULL)
	vc = find(...);
if (vc == NULL)
	vc = find(...);

Alternatively creating something like find_active_call() which would
match any of those states could also make the code a bit more readable.

> +	ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
> +					FSO_GSMC_INTERFACE,
> +					"Release", NULL, NULL,
> +					DBUS_TYPE_INT32, &vc->call_index,
> +					DBUS_TYPE_INVALID);
> +
> +

Extra empty line.

> +void telephony_dial_number_req(void *telephony_device, const char *number)
> +{
> +	const char *clir, *callType = "voice";

No capital letters in variable names.

> +#if 0
> +	if (!strncmp(number, "*31#", 4)) {
> +		number += 4;
> +		clir = "enabled";
> +	} else if (!strncmp(number, "#31#", 4)) {
> +		number += 4;
> +		clir =  "disabled";
> +	} else
> +		clir = "default";
> +#endif

Is this really code that you think can be enabled later? If not I'd just
remove it instead of having it commented out.

> +	ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
> +                        FSO_GSMC_INTERFACE,
> +			"SendDtmf", NULL, NULL,
> +			DBUS_TYPE_STRING, &tone_string,
> +			DBUS_TYPE_INVALID);

Looks like the indentation is somehow screwed up in the first
continuation line. In general the rule for indenting continuation lines
is: same indentation for all continuation lines, at least two tabs more
than the first line and as much as possible as long as the lines stay
less than 80 columns.

> +	if (vc = find_vc_with_status(CALL_STATUS_INCOMING)) {
> +		cmd = act;
> +	} else if (vc = find_vc_with_status(CALL_STATUS_ACTIVE)) {
> +		cmd = rel;
> +	} else if (vc = find_vc_with_status(CALL_STATUS_DIALING)) {
> +		cmd = rel;
> +	}

No braces for one-line scopes.

> +	if (cmd) {
> +		err = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
> +					FSO_GSMC_INTERFACE,
> +					cmd, NULL, NULL,
> +					DBUS_TYPE_INT32, &vc->call_index,
> +					DBUS_TYPE_INVALID);
> +	}
> +	if (err < 0)
> +		telephony_key_press_rsp(telephony_device, CME_ERROR_AG_FAILURE);
> +        else
> +		telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);

Shouldn't it be an error if cmd is NULL? In general doing
initializations upon declaration, especially for error variables, should
be avoided. Would e.g. having a final "else err = -EINVAL" at the end of
the else/else if statement make sense (which would allow removing the
initialzation of err to 0?

Also the indentation of the second if-statments else line is with spaces
instead of tabs.

> +void telephony_phonebook_read_req(void *telephony_device, const char *readindex, int ATtype)

Looks like a possibly grater than 80 columns line.

> +void telephony_phonebook_storage_req(void *telephony_device, const char *readindex, int ATtype)
> +{
> +	telephony_phonebook_storage_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
> +}
> +
> +

Extra empty line.

> +	if (!dbus_message_get_args(reply, NULL,
> +				DBUS_TYPE_STRING, &name,
> +				DBUS_TYPE_STRING, &number,
> +				DBUS_TYPE_INVALID)) 

Extra space at the end of the last line.

> +	if (number_type == &subscriber_number) {
> +		g_free(subscriber_number);
> +		subscriber_number = g_strdup(number);
> +	}
> +
> +done:
> +	dbus_message_unref(reply);
> +}
> +
> +

Extra empty line.

> +static void retrieve_phonebook_reply(DBusPendingCall *call, void *user_data)
> +{
> +	DBusError err;
> +	DBusMessage *reply;
> +	DBusMessageIter iter, array;
> +	int ret = 0;

Instead of initializing ret upon declaration (and btw, we use "err"
instead of "ret" usually) you could set it to 0 right before the done
label.
point:

> +		if ((index >= phonebook_info.first) && (index <= phonebook_info.last)) {
> +			info = g_strdup_printf("%d,\"%s\",,\"%s\"", index, number, name);
> +			telephony_phonebook_read_ind(phonebook_info.telephony_device, info);

Looks like possibly grater than 80 columns lines.

> +	if (ret)
> +		telephony_phonebook_read_rsp(phonebook_info.telephony_device, CME_ERROR_AG_FAILURE);
> +	else
> +		telephony_phonebook_read_rsp(phonebook_info.telephony_device, CME_ERROR_NONE);

Same here.


> +}
> +
> +
> +

Two extra empty lines.

> +static void get_phonebook_info_reply(DBusPendingCall *call, void *user_data)
> +{
> +	DBusError err;
> +	DBusMessage *reply;
> +	DBusMessageIter iter, iter_entry, array;
> +	int ret = 0;

s/ret/err/ and try to rethink how the initialization upon declaration
could be avoided.

> +	int min_index=-1, max_index =-1, number_length = -1, name_length = -1;

Missing spaces before and after '='.

> +		if (g_str_equal(property, "min_index")) {
> +			dbus_message_iter_get_basic(&sub, &min_index);
> +		} else if (g_str_equal(property, "max_index")) {
> +			dbus_message_iter_get_basic(&sub, &max_index);
> +		} else if (g_str_equal(property, "number_length")) {
> +			dbus_message_iter_get_basic(&sub, &number_length);
> +		} else if (g_str_equal(property, "name_length")) {
> +			dbus_message_iter_get_basic(&sub, &name_length);
> +		}

No braces for one-line scopes.

> +	if (ret)
> +		telephony_phonebook_read_rsp(phonebook_info.telephony_device, CME_ERROR_AG_FAILURE);
> +	else
> +		telephony_phonebook_read_rsp(phonebook_info.telephony_device, CME_ERROR_NONE);

Possibly longer than 80-column lines.

 +	g_free(str);
> +	telephony_phonebook_storage_rsp(phonebook_info.telephony_device, CME_ERROR_NONE);
> +
> +done:
> +	dbus_message_unref(reply);
> +
> +}
> +
> +
> +

Two unnecessary extra empty lines.

> +	int ret = 0;

Same thing as already mentioned.

> +	gstr = g_string_new("(");
> +	for (i=0; i< n_s; i++) {

Missing spaces before and after '=', before '<'. Can you come up with a
more descriptive name for the n_s variable please?

> +		index = find_category(fso_categories, s[i]);
> +		if (index != -1) {
> +			debug("GSM %d: %s", index, gsm_categories[index]);
> +			if (i == 0)
> +				g_string_append_printf(gstr, "%s", gsm_categories[index]);
> +			else
> +				g_string_append_printf(gstr, ",%s", gsm_categories[index]);
> +		}
> +	}

Looks like some lines go beyone 80-colums. You can avoid this by doing

if (index == -1)
	continue;

which also (imho) makes the code more readable.

> +done:
> +	dbus_message_unref(reply);
> +	if (ret)
> +		telephony_phonebook_read_rsp(phonebook_info.telephony_device, CME_ERROR_AG_FAILURE);
> +	else
> +		telephony_phonebook_read_rsp(phonebook_info.telephony_device, CME_ERROR_NONE);

Looks like greater than 80-column lines again.

> +}
> +
> +
> +

Two extra empty lines.

> +void telephony_phonebook_storage_req(void *telephony_device, const char *storage, int ATtype)

Greater than 80-column line. No capital letters in variable names.

> +	int ret=0, index;

s/ret/err/, rethink how the initialization upon declaration could be
avoided (not to mention the missing spaces before and after '=').

> +	switch (ATtype) {
> +	case ATQUERY:      // =?
> +		ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
> +			FSO_SIM_INTERFACE,
> +			"ListPhonebooks",
> +			list_phonebooks_reply, NULL,
> +			DBUS_TYPE_INVALID);

No C++ comments, the spit continuation lines need more indentation (at
least two more than the original line).

> +	case ATSET:         // =
> +		debug("Phonebook request to be %s", storage);
> +		index = find_category(gsm_categories, storage);
> +		debug ("Phonebook found at %d", index);

No space between debug and (

> +		if (index == -1)
> +			ret = -1;
> +		else {
> +			phonebook_info.category = index;
> +			telephony_phonebook_storage_rsp(telephony_device, CME_ERROR_NONE);

Looks like greater than 80-column line.

> +		}
> +		break;
> +	default:
> +		ret = -1;
> +	}
> +	

Redundant tab-character on this empty line.

> +	if (ret < 0)
> +		telephony_phonebook_storage_rsp(telephony_device, CME_ERROR_AG_FAILURE);

Greater than 80-column line.

> +}
> +
> +

Unnecessary empty line.

> +void telephony_phonebook_read_req(void *telephony_device, const char *readindex, int ATtype)

Greater than 80 column line.

> +{
> +	int size, ret=0;
> +	debug("telephony-fso: got pbook read request: %s", readindex);

Empty line after variable declarations. s/ret/err/. Rethink
initialization upon declaration. Missing space before and after '='

> +	switch (ATtype) {
> +	case ATQUERY:          // =?

No C++ comments.

> +		ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
> +		FSO_SIM_INTERFACE,
> +			"GetPhonebookInfo",
> +			get_phonebook_info_reply, NULL,
> +			DBUS_TYPE_STRING, &fso_categories[phonebook_info.category],
> +			DBUS_TYPE_INVALID);

Incorrect indentation (e.g. first continuation line seems not to be
indented at all from the original line)

> +		phonebook_info.first=-1, phonebook_info.last=-1;

Missing spaces before and after '='.

> +		sscanf(readindex, "%d,%d", &phonebook_info.first, &phonebook_info.last);
> +		if (phonebook_info.first == -1)
> +			break;

Probably you'd also want to check for sscanf return value (i.e. == 2).
Maybe that's the only thing you should check for and not try to
initialize these variables here since you already do that in the
beginning of telephony-fso.c where you define the phonebook_info struct?

> +
> +		if (phonebook_info.last == -1) phonebook_info.last = phonebook_info.first;

Break this into two lines.

> +
> +		ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
> +			FSO_SIM_INTERFACE,
> +			"RetrievePhonebook",
> +			retrieve_phonebook_reply, NULL,
> +			DBUS_TYPE_STRING, &fso_categories[phonebook_info.category],
> +			DBUS_TYPE_INT32, &phonebook_info.first,
> +			DBUS_TYPE_INT32, &phonebook_info.last,
> +			DBUS_TYPE_INVALID);
> +		break;
> +
> +	default:
> +		ret = -1;
> +	}
> +
> +	if (ret < 0)
> +		telephony_phonebook_read_rsp(telephony_device, CME_ERROR_AG_FAILURE);
> +
> +}
> +
> +
> +

Unnecessary empty line at the end of the function and two unnecessary
empty lines after it.

> +static void parse_gsmcall_property(const char *property, DBusMessageIter sub, struct voice_call *vc)

Too long line.

> +	if (g_str_equal(property, "direction")) {
> +		dbus_message_iter_get_basic(&sub, &direction);
> +	} else if (g_str_equal(property, "peer")) {
> +		dbus_message_iter_get_basic(&sub, &peer);
> +		vc->number = g_strdup(peer);
> +	} else if (g_str_equal(property, "reason")) {
> +		dbus_message_iter_get_basic(&sub, &reason);
> +	} else if (g_str_equal(property, "auxstatus")) {
> +		dbus_message_iter_get_basic(&sub, &auxstatus);
> +	} else if (g_str_equal(property, "line")) {
> +		dbus_message_iter_get_basic(&sub, &line);
> +	}

No braces for one-line scopes.

> +}
> +
> +

Unnecessary empty line.

> +	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
> +	error("Unexpected signature in gsmcall PropertyChanged signal");
> +		return TRUE;
> +	}

Incorrect indentation and no braces needed for one-line scope.

> +	dbus_message_iter_get_basic(&iter, &status);
> +
> +	debug("**** gsmProp Changed id:%d status: %s", call_index, status);
> +
> +

Unnecessary empty line.

> +	vc = find_vc(call_index);
> +	if (!vc) {
> +		vc = g_new0(struct voice_call, 1);
> +	if (!vc)
> +		return TRUE;

g_new0 is guaranteed to succeed or else it will call abort() so the NULL
check is redundant.

> +	vc->call_index = call_index;
> +	calls = g_slist_append(calls, vc);
> +	}

Looks like some incorrect indentation is going on here (since the ending
brace has the same indentation as the preceeding lines.

> +		if (dbus_message_iter_get_arg_type(&iter_property)
> +			!= DBUS_TYPE_STRING) {
> +			error("Unexpected signature in gsmcallPropertyChanged signal");
> +			return TRUE;
> +		}

Incorrect indentation for the split if-line. The continuation line
should be indented by at least two tabs to clearly separate it from the
actual branch code.

> +	return TRUE;
> +}
> +
> +
> +
> +

Three unnecessary empty lines.

> +}
> +
> +

Unnecessary empty line.

> +	/* ARRAY -> ENTRY -> VARIANT*/

Space before */

> +		dbus_message_iter_recurse(&iter_property, &sub);
> +
> +		parse_registration_property(property, sub);
> +
> +                dbus_message_iter_next(&iter_entry);

Incorrect indentation for the last line.

> +	}
> +	
> +done:

Redundant tab character on the empty line.

> +	return TRUE;
> +}
> +
> +

Unnecessary empty line.

> +done:
> +	dbus_message_unref(reply);
> +}
> +
> +

Unnecessary empty line.

> +static gboolean handle_registration_property_changed(DBusConnection *conn,
> +						DBusMessage *msg, void *data)
> +{
> +	return (handle_registration_property(msg));
> +}

No () needed around the value given to return.


> +	if (reply_check_error(&err, reply)) {
> +		goto done;
> +	}

No braces for one-line scope (though I realize this one is probably
inherited from telephony-maemo.c which I'm responsible for :)

> --- a/audio/telephony.h
> +++ b/audio/telephony.h
> @@ -127,6 +127,12 @@ typedef enum {
>  	CME_ERROR_NETWORK_NOT_ALLOWED	= 32,
>  } cme_error_t;
>  
> +/* AT command types */
> +#define ATNONE  0
> +#define ATQUERY 1
> +#define ATCHECK 2
> +#define ATSET   3

These should probably be an enum and have some namespacing (e.g.
AT_TYPE_). To be consistent with the AT command spec terminology (I've
been looking at 3GPP TS 07.07) it should be s/QUERY/TEST/ and
s/CHECK/READ/.

There were probably other issues in the patch that I missed but it'd be
nice if you could fix the already mentioned problems first and then I'll
take a second look.

Johan
