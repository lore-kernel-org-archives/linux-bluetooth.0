Return-Path: <cyrus@holtmann.org>
Subject: Re: Phonebook functions for BlueZ
From: Felix Huber <felix.huber@schyf.de>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100301192050.GA25876@jh-x301>
References: <4B8A3EEA.3030901@schyf.de>  <20100301192050.GA25876@jh-x301>
Content-Type: multipart/mixed; boundary="=-5zEhbNZNFf6dUFonqOhw"
Date: Sun, 07 Mar 2010 18:15:02 +0100
Message-ID: <1267982102.7714.87.camel@rb-l1.nos.office>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-5zEhbNZNFf6dUFonqOhw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Johan,

attached is the beautified version of the patch. I have deleted all the
comments referring to space, tabs, extra parenthesis and empty lines
since there are silenty fixed. I have a script that should take care of
that (at least I thought I had). The rest of the remarks are those where
I need feedback, discussion etc...

One more word of warning: Some People seem to have started to use this
patch on the OpenMoko. In order to use it, you MUST update a few files
of the FSO framework. Look at my commits at the framework git.

Am Montag, den 01.03.2010, 16:20 -0300 schrieb Johan Hedberg:
> Hi Felix,
> 
> On Sun, Feb 28, 2010, Felix Huber wrote:
> > I have analyzed the data traffic of my car handsfree set and implemented
> > the functions for the phonebook retrieval via the CPBR and CPBS
> > commands. In addition, I added a telephony driver for the FSO middleware
> > with which I tested the new functions using a Parrot CK3100 car kit and
> > a Jabra ear plug using version 4.61 of BlueZ. The other telephony
> > drivers just have empty functions that reject the new commands in order
> > not to break the APIs.
> > 
> > Attached is the patch file for the git repository.
> 
> Thanks for this contribution! In general the patch looks quite ok,
> however before pushing this upstream there are a some coding style
> issues that'd need to be fixed:
> 
> > +int get_ATtype(const char *buf, int *offset)
> > +{
> > +	const char *ATquery = "=?", *ATcheck ="?", *ATset = "=";
> 
> We usually don't use capital letters in any variable or function names.
> Pre-processor defines are an exception. So use something like
> get_at_type, at_query, etc.
Well usually, but since AT in this case is a proper name, I found it
very confusing to read it like the prepostion "at" or even a spelled-out
@-sign. I added an underscore for better indication of what it is.

>  Also, since get_ATtype is only used within
> headset.c you have to declare it static.
done


> > +char *fso_categories[NUM_CATEGORIES] = {"contacts", "emergency", "fixed", "dialed", "received", "missed", "own"};
> > +char *gsm_categories[NUM_CATEGORIES] = {"\"SM\"",   "\"EN\"",    "\"FD\"","\"DC\"", "\"RC\"",   "\"MC\"", "\"ON\""};

> Probably you could split these to fit within 80 columns.
Done, but now we loose the one-to-one correspondance.


> > +		if (!strcmp(phonebooks[i], category))
> 
> The convention has usually been to use == 0 in the case of strcmp for
> readability.
> 
Not quite, as it seems: I looked at the other files and they also used
the ! (including one commited by you :) ). So I chose the logical not,
which also frees one from having to handle 0 vs. NULL.

> > +static int send_method_call(const char *dest, const char *path,
> > +				const char *interface, const char *method,
> > +				DBusPendingCallNotifyFunction cb,
> > +				void *user_data, int type, ...)
> 
> Since this and many other functions are shared with (or actually copied
> from) telephony-maemo.c would it make sense to put them to some shared
> c-file (it's fine if this is a separate commit later).
Agreed, but since not all telefony-* files use it, it will create dead
code unless we put those functions into a lib.

> 
> > +	if ((vc = find_vc_with_status(CALL_STATUS_ACTIVE))) {
> > +	} else if ((vc = find_vc_with_status(CALL_STATUS_DIALING))) {
> > +	} else if ((vc = find_vc_with_status(CALL_STATUS_INCOMING))) {
> > +	}
> 
> The purpose of this construction isn't imediately clear imo. Wouldn't
> something like doing specific NULL checks after each find() call be more
> readable? I.e.
> 
Well, to me it was clear that these are nested calls until a valid vc is
found. But anyway, I copied this from telephony-ofono and tried to stay
close to the original code for better re-recognition. So either both
should be changed or none but not be strict only on new code, since this
makes copy-and-paste ineffective.


> > +void telephony_dial_number_req(void *telephony_device, const char *number)
> > +{
> > +	const char *clir, *callType = "voice";
> 
> No capital letters in variable names.
> 
Done

> > +#if 0
> > +	if (!strncmp(number, "*31#", 4)) {
> > +		number += 4;
> > +		clir = "enabled";
> > +	} else if (!strncmp(number, "#31#", 4)) {
> > +		number += 4;
> > +		clir =  "disabled";
> > +	} else
> > +		clir = "default";
> > +#endif
> 
> Is this really code that you think can be enabled later? If not I'd just
> remove it instead of having it commented out.
> 
Yes, it is needed. My car kit (and maybe others) have a menu to activate
this, but the current FSO API cannot handle it yet. Since this driver
needs to be update anyhow once the opimd is final, I left it in so it
cannot get forgotten to be reenabled.


> > +	if (cmd) {
> > +		err = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
> > +					FSO_GSMC_INTERFACE,
> > +					cmd, NULL, NULL,
> > +					DBUS_TYPE_INT32, &vc->call_index,
> > +					DBUS_TYPE_INVALID);
> > +	}
> > +	if (err < 0)
> > +		telephony_key_press_rsp(telephony_device, CME_ERROR_AG_FAILURE);
> > +        else
> > +		telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
> 
> Shouldn't it be an error if cmd is NULL? In general doing
> initializations upon declaration, especially for error variables, should
> be avoided. Would e.g. having a final "else err = -EINVAL" at the end of
> the else/else if statement make sense (which would allow removing the
> initialzation of err to 0?
No no, beware! It can happen that the other side of the phone call just hung up
before the key press or that a nasty user presses a key when nothing is going on.
In this case, the press is silenty ignored instead of confusing some headsets with an
unexpected failure.



> > +static void retrieve_phonebook_reply(DBusPendingCall *call, void *user_data)
> > +{
> > +	DBusError err;
> > +	DBusMessage *reply;
> > +	DBusMessageIter iter, array;
> > +	int ret = 0;
> 
> Instead of initializing ret upon declaration (and btw, we use "err"
> instead of "ret" usually) you could set it to 0 right before the done
> label.
Again, I checked with the other telephony files: they use ret for their
codes and err for DBus error. So I stayed consistent with the names.


> > +	gstr = g_string_new("(");
> > +	for (i=0; i< n_s; i++) {
> 
> Missing spaces before and after '=', before '<'. Can you come up with a
> more descriptive name for the n_s variable please?
What about num_strings? This is my feeling only, since I copied this
from the DBus tutorial.

> Looks like some lines go beyone 80-colums. You can avoid this by doing
> 
> if (index == -1)
> 	continue;
> 
> which also (imho) makes the code more readable.
Done



> > +		sscanf(readindex, "%d,%d", &phonebook_info.first, &phonebook_info.last);
> > +		if (phonebook_info.first == -1)
> > +			break;
> 
> Probably you'd also want to check for sscanf return value (i.e. == 2).
> Maybe that's the only thing you should check for and not try to
> initialize these variables here since you already do that in the
> beginning of telephony-fso.c where you define the phonebook_info struct?
Nope, the arguments are optional and both 0,1 or two conversions can
happen, so the return of sscanf serves nothing in this case.
> 

> Break this into two lines.
Done


> > +	if (g_str_equal(property, "direction")) {
> > +		dbus_message_iter_get_basic(&sub, &direction);
> > +	} else if (g_str_equal(property, "peer")) {
> > +		dbus_message_iter_get_basic(&sub, &peer);
> > +		vc->number = g_strdup(peer);
> > +	} else if (g_str_equal(property, "reason")) {
> > +		dbus_message_iter_get_basic(&sub, &reason);
> > +	} else if (g_str_equal(property, "auxstatus")) {
> > +		dbus_message_iter_get_basic(&sub, &auxstatus);
> > +	} else if (g_str_equal(property, "line")) {
> > +		dbus_message_iter_get_basic(&sub, &line);
> > +	}
> 
> No braces for one-line scopes.
Well, here we have a conflict: The kernel style guide says that if one
of the blocks has braces the other one should also have, even if it is a
single line.


> > +	vc = find_vc(call_index);
> > +	if (!vc) {
> > +		vc = g_new0(struct voice_call, 1);
> > +	if (!vc)
> > +		return TRUE;
> 
> g_new0 is guaranteed to succeed or else it will call abort() so the NULL
> check is redundant.
What a nice feature, done.


> > +}
> > +
> > +
> 
> Unnecessary empty line.
> 
> > +	/* ARRAY -> ENTRY -> VARIANT*/
> 
> Space before */
Done, copy and paste telephony-ofono.c -> should be fixed there too.

> 
> > +	if (reply_check_error(&err, reply)) {
> > +		goto done;
> > +	}
> 
> No braces for one-line scope (though I realize this one is probably
> inherited from telephony-maemo.c which I'm responsible for :)
Nope, unfortunately, you are not guilty. My code (and done). 

> 
> > --- a/audio/telephony.h
> > +++ b/audio/telephony.h
> > @@ -127,6 +127,12 @@ typedef enum {
> >  	CME_ERROR_NETWORK_NOT_ALLOWED	= 32,
> >  } cme_error_t;
> >  
> > +/* AT command types */
> > +#define ATNONE  0
> > +#define ATQUERY 1
> > +#define ATCHECK 2
> > +#define ATSET   3

> These should probably be an enum and have some namespacing (e.g.
> AT_TYPE_).
Again, in order to be consistent with the existing codes, I looked at
what the other files do. I adopted the use of the Call parameters, like
CALL_STATUS_ACTIVE. These are all #defines


>  To be consistent with the AT command spec terminology (I've
> been looking at 3GPP TS 07.07) it should be s/QUERY/TEST/ and
> s/CHECK/READ/.
Done (I don't have a copy of the spec)


Felix



--=-5zEhbNZNFf6dUFonqOhw
Content-Disposition: attachment; filename*0=0001-Added-support-for-HFP-phonebook-functions-and-FSO-mi.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-Added-support-for-HFP-phonebook-functions-and-FSO-mi.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 8c30b90811b307dc42d5003347902b121d4fa7d9 Mon Sep 17 00:00:00 2001
From: Felix Huber <felix.huber@schyf.de>
Date: Sun, 7 Mar 2010 18:07:47 +0100
Subject: [PATCH] Added support for HFP phonebook functions and FSO middleware

---
 audio/headset.c         |  265 ++++++----
 audio/telephony-dummy.c |   11 +
 audio/telephony-fso.c   | 1412 +++++++++++++++++++++++++++++++++++++++++++++++
 audio/telephony-maemo.c |   10 +
 audio/telephony-ofono.c |   11 +
 audio/telephony.h       |   12 +
 6 files changed, 1615 insertions(+), 106 deletions(-)
 create mode 100644 audio/telephony-fso.c

diff --git a/audio/headset.c b/audio/headset.c
index 15d3672..0360f26 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -128,25 +128,6 @@ struct pending_connect {
 	uint16_t svclass;
 };
 
-struct headset_slc {
-	char buf[BUF_SIZE];
-	int data_start;
-	int data_length;
-
-	gboolean cli_active;
-	gboolean cme_enabled;
-	gboolean cwa_enabled;
-	gboolean pending_ring;
-	gboolean inband_ring;
-	gboolean nrec;
-	gboolean nrec_req;
-
-	int sp_gain;
-	int mic_gain;
-
-	unsigned int hf_features;
-};
-
 struct headset {
 	uint32_t hsp_handle;
 	uint32_t hfp_handle;
@@ -163,14 +144,28 @@ struct headset {
 
 	guint dc_timer;
 
+	char buf[BUF_SIZE];
+	int data_start;
+	int data_length;
+
 	gboolean hfp_active;
 	gboolean search_hfp;
+	gboolean cli_active;
+	gboolean cme_enabled;
+	gboolean cwa_enabled;
+	gboolean pending_ring;
+	gboolean inband_ring;
+	gboolean nrec;
+	gboolean nrec_req;
 
 	headset_state_t state;
 	struct pending_connect *pending;
 
+	int sp_gain;
+	int mic_gain;
+
+	unsigned int hf_features;
 	headset_lock_t lock;
-	struct headset_slc *slc;
 };
 
 struct event {
@@ -343,15 +338,14 @@ static int headset_send(struct headset *hs, char *format, ...)
 static int supported_features(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 	int err;
 
 	if (strlen(buf) < 9)
 		return -EINVAL;
 
-	slc->hf_features = strtoul(&buf[8], NULL, 10);
+	hs->hf_features = strtoul(&buf[8], NULL, 10);
 
-	print_hf_features(slc->hf_features);
+	print_hf_features(hs->hf_features);
 
 	err = headset_send(hs, "\r\n+BRSF: %u\r\n", ag.features);
 	if (err < 0)
@@ -540,12 +534,10 @@ static void send_foreach_headset(GSList *devices,
 
 static int cli_cmp(struct headset *hs)
 {
-	struct headset_slc *slc = hs->slc;
-
 	if (!hs->hfp_active)
 		return -1;
 
-	if (slc->cli_active)
+	if (hs->cli_active)
 		return 0;
 	else
 		return -1;
@@ -568,7 +560,6 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	int sk;
 	struct audio_device *dev = user_data;
 	struct headset *hs = dev->headset;
-	struct headset_slc *slc = hs->slc;
 	struct pending_connect *p = hs->pending;
 
 	if (err) {
@@ -608,12 +599,12 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	headset_set_state(dev, HEADSET_STATE_PLAYING);
 
-	if (slc->pending_ring) {
+	if (hs->pending_ring) {
 		ring_timer_cb(NULL);
 		ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL,
 						ring_timer_cb,
 						NULL);
-		slc->pending_ring = FALSE;
+		hs->pending_ring = FALSE;
 	}
 }
 
@@ -693,10 +684,9 @@ static void hfp_slc_complete(struct audio_device *dev)
 static int telephony_generic_rsp(struct audio_device *device, cme_error_t err)
 {
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 
 	if (err != CME_ERROR_NONE) {
-		if (slc->cme_enabled)
+		if (hs->cme_enabled)
 			return headset_send(hs, "\r\n+CME ERROR: %d\r\n", err);
 		else
 			return headset_send(hs, "\r\nERROR\r\n");
@@ -709,7 +699,6 @@ int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err)
 {
 	struct audio_device *device = telephony_device;
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 	int ret;
 
 	if (err != CME_ERROR_NONE)
@@ -722,7 +711,7 @@ int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err)
 	if (hs->state != HEADSET_STATE_CONNECTING)
 		return 0;
 
-	if (slc->hf_features & HF_FEATURE_CALL_WAITING_AND_3WAY &&
+	if (hs->hf_features & HF_FEATURE_CALL_WAITING_AND_3WAY &&
 			ag.features & AG_FEATURE_THREE_WAY_CALLING)
 		return 0;
 
@@ -876,12 +865,11 @@ static int terminate_call(struct audio_device *device, const char *buf)
 static int cli_notification(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 
 	if (strlen(buf) < 9)
 		return -EINVAL;
 
-	slc->cli_active = buf[8] == '1' ? TRUE : FALSE;
+	hs->cli_active = buf[8] == '1' ? TRUE : FALSE;
 
 	return headset_send(hs, "\r\nOK\r\n");
 }
@@ -949,7 +937,6 @@ static int dial_number(struct audio_device *device, const char *buf)
 static int signal_gain_setting(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 	const char *property;
 	const char *name;
 	dbus_uint16_t gain;
@@ -968,18 +955,18 @@ static int signal_gain_setting(struct audio_device *device, const char *buf)
 
 	switch (buf[5]) {
 	case HEADSET_GAIN_SPEAKER:
-		if (slc->sp_gain == gain)
+		if (hs->sp_gain == gain)
 			goto ok;
 		name = "SpeakerGainChanged";
 		property = "SpeakerGain";
-		slc->sp_gain = gain;
+		hs->sp_gain = gain;
 		break;
 	case HEADSET_GAIN_MICROPHONE:
-		if (slc->mic_gain == gain)
+		if (hs->mic_gain == gain)
 			goto ok;
 		name = "MicrophoneGainChanged";
 		property = "MicrophoneGain";
-		slc->mic_gain = gain;
+		hs->mic_gain = gain;
 		break;
 	default:
 		error("Unknown gain setting");
@@ -1043,16 +1030,15 @@ static int list_current_calls(struct audio_device *device, const char *buf)
 static int extended_errors(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 
 	if (strlen(buf) < 9)
 		return -EINVAL;
 
 	if (buf[8] == '1') {
-		slc->cme_enabled = TRUE;
+		hs->cme_enabled = TRUE;
 		debug("CME errors enabled for headset %p", hs);
 	} else {
-		slc->cme_enabled = FALSE;
+		hs->cme_enabled = FALSE;
 		debug("CME errors disabled for headset %p", hs);
 	}
 
@@ -1062,16 +1048,15 @@ static int extended_errors(struct audio_device *device, const char *buf)
 static int call_waiting_notify(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 
 	if (strlen(buf) < 9)
 		return -EINVAL;
 
 	if (buf[8] == '1') {
-		slc->cwa_enabled = TRUE;
+		hs->cwa_enabled = TRUE;
 		debug("Call waiting notification enabled for headset %p", hs);
 	} else {
-		slc->cwa_enabled = FALSE;
+		hs->cwa_enabled = FALSE;
 		debug("Call waiting notification disabled for headset %p", hs);
 	}
 
@@ -1092,10 +1077,9 @@ int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err)
 {
 	struct audio_device *device = telephony_device;
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 
 	if (err == CME_ERROR_NONE)
-		slc->nrec = hs->slc->nrec_req;
+		hs->nrec = hs->nrec_req;
 
 	return telephony_generic_rsp(telephony_device, err);
 }
@@ -1139,17 +1123,16 @@ static int operator_selection(struct audio_device *device, const char *buf)
 static int nr_and_ec(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 
 	if (strlen(buf) < 9)
 		return -EINVAL;
 
 	if (buf[8] == '0')
-		slc->nrec_req = FALSE;
+		hs->nrec_req = FALSE;
 	else
-		slc->nrec_req = TRUE;
+		hs->nrec_req = TRUE;
 
-	telephony_nr_and_ec_req(device, slc->nrec_req);
+	telephony_nr_and_ec_req(device, hs->nrec_req);
 
 	return 0;
 }
@@ -1171,6 +1154,82 @@ static int voice_dial(struct audio_device *device, const char *buf)
 	return 0;
 }
 
+static int get_AT_type(const char *buf, int *offset)
+{
+	const char *AT_test = "=?", *AT_read ="?", *AT_set = "=";
+
+	if (!strncmp(buf, AT_test, 2)) {
+		*offset = 2;
+		return AT_TEST;
+	} else if (!strncmp(buf, AT_read, 1)) {
+		*offset = 1;
+		return AT_READ;
+	} else if (!strncmp(buf, AT_set, 1)) {
+		*offset = 1;
+		return AT_SET;
+	} else {
+		*offset = 0;
+		return AT_NONE;
+	}
+}
+
+int telephony_phonebook_storage_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+int telephony_phonebook_storage_ind(void *telephony_device,
+						const char *storagelist)
+{
+	struct audio_device *device = telephony_device;
+	struct headset *hs = device->headset;
+
+	headset_send(hs, "\r\n+CPBS: %s\r\n", storagelist);
+
+	return 0;
+}
+
+static int phonebook_storage(struct audio_device *device, const char *buf)
+{
+	int AT_type, offset;
+
+	if (strlen(buf) < 8)
+		return -EINVAL;
+
+	AT_type = get_AT_type(&buf[7], &offset);
+	telephony_phonebook_storage_req(device, &buf[7+offset], AT_type);
+
+	return 0;
+}
+
+int telephony_phonebook_read_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+int telephony_phonebook_read_ind(void *telephony_device, const char *entrylist)
+{
+	struct audio_device *device = telephony_device;
+	struct headset *hs = device->headset;
+
+	headset_send(hs, "\r\n+CPBR: %s\r\n", entrylist);
+
+	return 0;
+}
+
+static int phonebook_read(struct audio_device *device, const char *buf)
+{
+	int AT_type, offset;
+
+	if (strlen(buf) < 8) 
+		return -EINVAL;
+
+	AT_type = get_AT_type(&buf[7], &offset);
+	telephony_phonebook_read_req(device, &buf[7+offset], AT_type);
+
+	return 0;
+}
+
 static struct event event_callbacks[] = {
 	{ "ATA", answer_call },
 	{ "ATD", dial_number },
@@ -1192,6 +1251,8 @@ static struct event event_callbacks[] = {
 	{ "AT+COPS", operator_selection },
 	{ "AT+NREC", nr_and_ec },
 	{ "AT+BVRA", voice_dial },
+	{ "AT+CPBS", phonebook_storage },
+	{ "AT+CPBR", phonebook_read },
 	{ 0 }
 };
 
@@ -1231,7 +1292,6 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 				struct audio_device *device)
 {
 	struct headset *hs;
-	struct headset_slc *slc;
 	unsigned char buf[BUF_SIZE];
 	gsize bytes_read = 0;
 	gsize free_space;
@@ -1240,7 +1300,6 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 		return FALSE;
 
 	hs = device->headset;
-	slc = hs->slc;
 
 	if (cond & (G_IO_ERR | G_IO_HUP)) {
 		debug("ERR or HUP on RFCOMM socket");
@@ -1251,8 +1310,7 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 				&bytes_read) != G_IO_ERROR_NONE)
 		return TRUE;
 
-	free_space = sizeof(slc->buf) - slc->data_start -
-			slc->data_length - 1;
+	free_space = sizeof(hs->buf) - hs->data_start - hs->data_length - 1;
 
 	if (free_space < bytes_read) {
 		/* Very likely that the HS is sending us garbage so
@@ -1261,45 +1319,45 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 	}
 
-	memcpy(&slc->buf[slc->data_start], buf, bytes_read);
-	slc->data_length += bytes_read;
+	memcpy(&hs->buf[hs->data_start], buf, bytes_read);
+	hs->data_length += bytes_read;
 
 	/* Make sure the data is null terminated so we can use string
 	 * functions */
-	slc->buf[slc->data_start + slc->data_length] = '\0';
+	hs->buf[hs->data_start + hs->data_length] = '\0';
 
-	while (slc->data_length > 0) {
+	while (hs->data_length > 0) {
 		char *cr;
 		int err;
 		off_t cmd_len;
 
-		cr = strchr(&slc->buf[slc->data_start], '\r');
+		cr = strchr(&hs->buf[hs->data_start], '\r');
 		if (!cr)
 			break;
 
-		cmd_len = 1 + (off_t) cr - (off_t) &slc->buf[slc->data_start];
+		cmd_len = 1 + (off_t) cr - (off_t) &hs->buf[hs->data_start];
 		*cr = '\0';
 
 		if (cmd_len > 1)
-			err = handle_event(device, &slc->buf[slc->data_start]);
+			err = handle_event(device, &hs->buf[hs->data_start]);
 		else
 			/* Silently skip empty commands */
 			err = 0;
 
 		if (err == -EINVAL) {
 			error("Badly formated or unrecognized command: %s",
-					&slc->buf[slc->data_start]);
+					&hs->buf[hs->data_start]);
 			err = headset_send(hs, "\r\nERROR\r\n");
 		} else if (err < 0)
 			error("Error handling command %s: %s (%d)",
-						&slc->buf[slc->data_start],
+						&hs->buf[hs->data_start],
 						strerror(-err), -err);
 
-		slc->data_start += cmd_len;
-		slc->data_length -= cmd_len;
+		hs->data_start += cmd_len;
+		hs->data_length -= cmd_len;
 
-		if (!slc->data_length)
-			slc->data_start = 0;
+		if (!hs->data_length)
+			hs->data_start = 0;
 	}
 
 	return TRUE;
@@ -1357,9 +1415,6 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	debug("%s: Connected to %s", dev->path, hs_address);
 
-	hs->slc = g_new0(struct headset_slc, 1);
-	hs->slc->nrec = TRUE;
-
 	/* In HFP mode wait for Service Level Connection */
 	if (hs->hfp_active)
 		return;
@@ -1834,11 +1889,10 @@ static DBusMessage *hs_get_speaker_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 	DBusMessage *reply;
 	dbus_uint16_t gain;
 
-	if (hs->state < HEADSET_STATE_CONNECTED)
+	if (hs->state < HEADSET_STATE_CONNECTED || hs->sp_gain < 0)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
 						"Operation not Available");
 
@@ -1846,7 +1900,7 @@ static DBusMessage *hs_get_speaker_gain(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
-	gain = (dbus_uint16_t) slc->sp_gain;
+	gain = (dbus_uint16_t) hs->sp_gain;
 
 	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
 					DBUS_TYPE_INVALID);
@@ -1860,11 +1914,10 @@ static DBusMessage *hs_get_mic_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 	DBusMessage *reply;
 	dbus_uint16_t gain;
 
-	if (hs->state < HEADSET_STATE_CONNECTED || slc == NULL)
+	if (hs->state < HEADSET_STATE_CONNECTED || hs->mic_gain < 0)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
 						"Operation not Available");
 
@@ -1872,7 +1925,7 @@ static DBusMessage *hs_get_mic_gain(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
-	gain = (dbus_uint16_t) slc->mic_gain;
+	gain = (dbus_uint16_t) hs->mic_gain;
 
 	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
 					DBUS_TYPE_INVALID);
@@ -1887,7 +1940,6 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 	DBusMessage *reply;
 	int err;
 
@@ -1917,14 +1969,14 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 
 done:
 	if (type == HEADSET_GAIN_SPEAKER) {
-		slc->sp_gain = gain;
+		hs->sp_gain = gain;
 		g_dbus_emit_signal(conn, device->path,
 					AUDIO_HEADSET_INTERFACE,
 					"SpeakerGainChanged",
 					DBUS_TYPE_UINT16, &gain,
 					DBUS_TYPE_INVALID);
 	} else {
-		slc->mic_gain = gain;
+		hs->mic_gain = gain;
 		g_dbus_emit_signal(conn, device->path,
 					AUDIO_HEADSET_INTERFACE,
 					"MicrophoneGainChanged",
@@ -2001,13 +2053,11 @@ static DBusMessage *hs_get_properties(DBusConnection *conn,
 
 	/* SpeakerGain */
 	dict_append_entry(&dict, "SpeakerGain",
-				DBUS_TYPE_UINT16,
-				&device->headset->slc->sp_gain);
+				DBUS_TYPE_UINT16, &device->headset->sp_gain);
 
 	/* MicrophoneGain */
 	dict_append_entry(&dict, "MicrophoneGain",
-				DBUS_TYPE_UINT16,
-				&device->headset->slc->mic_gain);
+				DBUS_TYPE_UINT16, &device->headset->mic_gain);
 
 done:
 	dbus_message_iter_close_container(&iter, &dict);
@@ -2146,8 +2196,10 @@ static int headset_close_rfcomm(struct audio_device *dev)
 		hs->rfcomm = NULL;
 	}
 
-	g_free(hs->slc);
-	hs->slc = NULL;
+	hs->data_start = 0;
+	hs->data_length = 0;
+
+	hs->nrec = TRUE;
 
 	return 0;
 }
@@ -2202,7 +2254,12 @@ struct headset *headset_init(struct audio_device *dev, uint16_t svc,
 
 	hs = g_new0(struct headset, 1);
 	hs->rfcomm_ch = -1;
+	hs->sp_gain = -1;
+	hs->mic_gain = -1;
 	hs->search_hfp = server_is_enabled(&dev->src, HANDSFREE_SVCLASS_ID);
+	hs->hfp_active = FALSE;
+	hs->cli_active = FALSE;
+	hs->nrec = TRUE;
 
 	record = btd_device_get_record(dev->btd_dev, uuidstr);
 	if (!record)
@@ -2445,19 +2502,18 @@ int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 int headset_connect_sco(struct audio_device *dev, GIOChannel *io)
 {
 	struct headset *hs = dev->headset;
-	struct headset_slc *slc = hs->slc;
 
 	if (hs->sco)
 		return -EISCONN;
 
 	hs->sco = g_io_channel_ref(io);
 
-	if (slc->pending_ring) {
+	if (hs->pending_ring) {
 		ring_timer_cb(NULL);
 		ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL,
 						ring_timer_cb,
 						NULL);
-		slc->pending_ring = FALSE;
+		hs->pending_ring = FALSE;
 	}
 
 	return 0;
@@ -2476,7 +2532,6 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 void headset_set_state(struct audio_device *dev, headset_state_t state)
 {
 	struct headset *hs = dev->headset;
-	struct headset_slc *slc = hs->slc;
 	gboolean value;
 	const char *state_str;
 	headset_state_t old_state = hs->state;
@@ -2522,9 +2577,9 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					DBUS_TYPE_STRING, &state_str);
 		if (hs->state < state) {
 			if (ag.features & AG_FEATURE_INBAND_RINGTONE)
-				slc->inband_ring = TRUE;
+				hs->inband_ring = TRUE;
 			else
-				slc->inband_ring = FALSE;
+				hs->inband_ring = FALSE;
 			g_dbus_emit_signal(dev->conn, dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
@@ -2569,10 +2624,10 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					AUDIO_HEADSET_INTERFACE, "Playing",
 					DBUS_TYPE_BOOLEAN, &value);
 
-		if (slc->sp_gain >= 0)
-			headset_send(hs, "\r\n+VGS=%u\r\n", slc->sp_gain);
-		if (slc->mic_gain >= 0)
-			headset_send(hs, "\r\n+VGM=%u\r\n", slc->mic_gain);
+		if (hs->sp_gain >= 0)
+			headset_send(hs, "\r\n+VGS=%u\r\n", hs->sp_gain);
+		if (hs->mic_gain >= 0)
+			headset_send(hs, "\r\n+VGM=%u\r\n", hs->mic_gain);
 		break;
 	}
 
@@ -2681,7 +2736,7 @@ gboolean headset_get_nrec(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
 
-	return hs->slc->nrec;
+	return hs->nrec;
 }
 
 gboolean headset_get_sco_hci(struct audio_device *dev)
@@ -2738,7 +2793,6 @@ int telephony_incoming_call_ind(const char *number, int type)
 {
 	struct audio_device *dev;
 	struct headset *hs;
-	struct headset_slc *slc;
 
 	if (!active_devices)
 		return -ENODEV;
@@ -2746,7 +2800,6 @@ int telephony_incoming_call_ind(const char *number, int type)
 	/* Get the latest connected device */
 	dev = active_devices->data;
 	hs = dev->headset;
-	slc = hs->slc;
 
 	if (ag.ring_timer) {
 		debug("telephony_incoming_call_ind: already calling");
@@ -2755,16 +2808,16 @@ int telephony_incoming_call_ind(const char *number, int type)
 
 	/* With HSP 1.2 the RING messages should *not* be sent if inband
 	 * ringtone is being used */
-	if (!hs->hfp_active && slc->inband_ring)
+	if (!hs->hfp_active && hs->inband_ring)
 		return 0;
 
 	g_free(ag.number);
 	ag.number = g_strdup(number);
 	ag.number_type = type;
 
-	if (slc->inband_ring && hs->hfp_active &&
+	if (hs->inband_ring && hs->hfp_active &&
 					hs->state != HEADSET_STATE_PLAYING) {
-		slc->pending_ring = TRUE;
+		hs->pending_ring = TRUE;
 		return 0;
 	}
 
@@ -2790,10 +2843,10 @@ int telephony_calling_stopped_ind(void)
 	/* In case SCO isn't fully up yet */
 	dev = active_devices->data;
 
-	if (!dev->headset->slc->pending_ring && !ag.ring_timer)
+	if (!dev->headset->pending_ring && !ag.ring_timer)
 		return -EINVAL;
 
-	dev->headset->slc->pending_ring = FALSE;
+	dev->headset->pending_ring = FALSE;
 
 	return 0;
 }
@@ -2851,7 +2904,7 @@ static int cwa_cmp(struct headset *hs)
 	if (!hs->hfp_active)
 		return -1;
 
-	if (hs->slc->cwa_enabled)
+	if (hs->cwa_enabled)
 		return 0;
 	else
 		return -1;
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 2409a49..71d1d2b 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -225,6 +225,17 @@ void telephony_key_press_req(void *telephony_device, const char *keys)
 	telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
 }
 
+void telephony_phonebook_read_req(void *telephony_device, const char *readindex, int ATtype)
+{
+	telephony_phonebook_read_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
+void telephony_phonebook_storage_req(void *telephony_device, const char *readindex, int ATtype)
+{
+	telephony_phonebook_storage_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
+
 /* D-Bus method handlers */
 static DBusMessage *outgoing_call(DBusConnection *conn, DBusMessage *msg,
 					void *data)
diff --git a/audio/telephony-fso.c b/audio/telephony-fso.c
new file mode 100644
index 0000000..1086198
--- /dev/null
+++ b/audio/telephony-fso.c
@@ -0,0 +1,1412 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  telephony interface for Freesmartphone.org stack
+ *
+ *  Copyright (C) 2009-2010  Intel Corporation
+ *  Copyright (C) 2006-2009  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2010       Felix Huber
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus.h>
+
+#include "logging.h"
+#include "telephony.h"
+
+/* Mask bits for supported services */
+#define NETWORK_MASK_GPRS_SUPPORT       0x01
+#define NETWORK_MASK_COMPACT_GSM        0x02
+#define NETWORK_MASK_UMTS               0x04
+#define NETWORK_MASK_EGDGE              0x08
+#define NETWORK_MASK_HSDPA_AVAIL        0x10
+#define NETWORK_MASK_HSUPA_AVAIL        0x20
+
+/* network get cell info: cell type */
+#define NETWORK_UNKNOWN_CELL            0
+#define NETWORK_GSM_CELL                1
+#define NETWORK_WCDMA_CELL              2
+
+enum net_registration_status {
+	NETWORK_REG_STATUS_UNREGISTERED = 0x00,
+	NETWORK_REG_STATUS_HOME,
+	NETWORK_REG_STATUS_BUSY,
+	NETWORK_REG_STATUS_DENIED,
+	NETWORK_REG_STATUS_UNKOWN,
+	NETWORK_REG_STATUS_ROAM,
+};
+
+enum network_types {
+	NETWORK_GSM = 0,
+	NETWORK_COMPACT_GSM,
+	NETWORK_UMTS,
+	NETWORK_EDGE,
+	NETWORK_HSDPA,
+	NETWORK_PSUPA,
+	NETWORK_HSDPAHSUPA
+};
+
+
+struct voice_call {
+	dbus_int32_t call_index;
+	int status;
+	gboolean originating;
+	char *number;
+};
+
+static struct {
+	void *telephony_device;
+	int first;
+	int last;
+	int category;
+} phonebook_info = {
+	.telephony_device = NULL,
+	.first = -1,
+	.last = -1,
+	.category = 0
+};
+
+#define NUM_CATEGORIES 7
+char *fso_categories[NUM_CATEGORIES] = {"contacts", "emergency", "fixed",
+					"dialed", "received", "missed", "own"
+					};
+char *gsm_categories[NUM_CATEGORIES] = {"\"SM\"",   "\"EN\"",    "\"FD\"",
+					"\"DC\"", "\"RC\"",   "\"MC\"", "\"ON\""
+					};
+#define OWN_CATEGORY 6
+#define SIM_CATEGORY 0
+
+/* OM sends:
++CPBS: ("EN","BD","FD","DC","LD","RC","LR","MT","AD","SM","SD","MC","LM","AF","ON","UD")
+"EN" SIM (or ME) emergency number
+"FD" SIM fixed-dialing-phonebook
+"LD" SIM last-dialing-phonebook
+"BD" SIM barred-dialing phonebook
+"SD" SIM service numbers
+"DC" MT dialled calls list
+"RC" MT received calls list
+"LR" Last received numbers (nonstandard)
+"MT" combined MT and SIM/UICC phonebook
+"AD" Abbreviated dialing numbers (nonstandard)
+"LM" Last missed numbers (nonstandard)
+"AF" comb. of fixed and abbrev. dialing phonebook (nonstandard)
+"MC" MT missed (unanswered received) calls list
+"ON" active application in the UICC (GSM or USIM) or SIM card (or MT) own numbers (MSISDNs) list
+"UD" User defined
+*/
+
+static DBusConnection *connection = NULL;
+static char *last_dialed_number = NULL;
+static GSList *calls = NULL;
+
+#define FSO_BUS_NAME "org.freesmartphone.ogsmd"
+#define FSO_MODEM_OBJ_PATH "/org/freesmartphone/GSM/Device"
+#define FSO_NETWORKREG_INTERFACE "org.freesmartphone.GSM.Network"
+#define FSO_GSMC_INTERFACE "org.freesmartphone.GSM.Call"
+#define FSO_SIM_INTERFACE "org.freesmartphone.GSM.SIM"
+
+static guint registration_watch = 0;
+static guint voice_watch = 0;
+static guint device_watch = 0;
+
+/* HAL battery namespace key values */
+static int battchg_cur = -1;    /* "battery.charge_level.current" */
+static int battchg_last = -1;   /* "battery.charge_level.last_full" */
+static int battchg_design = -1; /* "battery.charge_level.design" */
+
+static struct {
+	uint8_t status;         /* act  'GSM' */
+	uint32_t cell_id;       /* cid  '51FD' */
+	uint32_t operator_code; /* code '26203' */
+	uint16_t lac;           /* lac  '233b' */
+	char *mode;             /* mode 'automatic' */
+	char *operator_name;    /* provider  'debitel' */
+	char *registration;     /* registration 'home' */
+	uint16_t signals_bar;   /* strength  '87' */
+} net = {
+	.status = NETWORK_REG_STATUS_UNREGISTERED,
+	.cell_id = 0,
+	.operator_code = 0,
+	.lac = 0,
+	.mode = NULL,
+	.operator_name = NULL,
+	.registration = NULL,
+	.signals_bar = 0,
+};
+
+static const char *chld_str = "0,1,1x,2,2x,3,4";
+static char *subscriber_number = NULL;
+
+static gboolean events_enabled = FALSE;
+
+/* Response and hold state
+ * -1 = none
+ *  0 = incoming call is put on hold in the AG
+ *  1 = held incoming call is accepted in the AG
+ *  2 = held incoming call is rejected in the AG
+ */
+static int response_and_hold = -1;
+
+static struct indicator fso_indicators[] =
+{
+	{ "battchg",	"0-5",	5,	TRUE },
+	{ "signal",	"0-5",	5,	TRUE },
+	{ "service",	"0,1",	1,	TRUE },
+	{ "call",	"0,1",	0,	TRUE },
+	{ "callsetup",	"0-3",	0,	TRUE },
+	{ "callheld",	"0-2",	0,	FALSE },
+	{ "roam",	"0,1",	0,	TRUE },
+	{ NULL }
+};
+
+static void vc_free(struct voice_call *vc)
+{
+	if (!vc)
+		return;
+	g_free(vc->number);
+	g_free(vc);
+}
+
+static struct voice_call *find_vc(dbus_int32_t call_index)
+{
+	GSList *l;
+
+	for (l = calls; l != NULL; l = l->next) {
+		struct voice_call *vc = l->data;
+
+		if (vc->call_index == call_index)
+			return vc;
+	}
+
+	return NULL;
+}
+
+static struct voice_call *find_vc_with_status(int status)
+{
+	GSList *l;
+
+	for (l = calls; l != NULL; l = l->next) {
+		struct voice_call *vc = l->data;
+
+		if (vc->status == status)
+			return vc;
+	}
+
+	return NULL;
+}
+
+static gboolean iter_get_basic_args(DBusMessageIter *iter,
+						int first_arg_type, ...)
+{
+	int type;
+	va_list ap;
+
+	va_start(ap, first_arg_type);
+
+	for (type = first_arg_type; type != DBUS_TYPE_INVALID;
+		type = va_arg(ap, int)) {
+		void *value = va_arg(ap, void *);
+		int real_type = dbus_message_iter_get_arg_type(iter);
+
+		if (real_type != type) {
+			error("iter_get_basic_args: expected %c but got %c",
+				(char) type, (char) real_type);
+			break;
+		}
+
+		dbus_message_iter_get_basic(iter, value);
+		dbus_message_iter_next(iter);
+	}
+
+	va_end(ap);
+
+	return type == DBUS_TYPE_INVALID ? TRUE : FALSE;
+}
+
+static int reply_check_error(DBusError *err, DBusMessage *reply)
+{
+	dbus_error_init(err);
+	if (dbus_set_error_from_message(err, reply)) {
+		error("fso replied with an error: %s, %s",
+			err->name, err->message);
+		dbus_error_free(err);
+		return -1;
+	}
+	return 0;
+}
+
+static int find_category(char **phonebooks, const char *category)
+{
+	int i;
+	for (i = 0; i < NUM_CATEGORIES; i++) {
+		if (!strcmp(phonebooks[i], category))
+			return i;
+	}
+	return -1;
+}
+
+void telephony_device_connected(void *telephony_device)
+{
+	debug("telephony-fso: device %p connected", telephony_device);
+}
+
+void telephony_device_disconnected(void *telephony_device)
+{
+	debug("telephony-fso: device %p disconnected", telephony_device);
+	events_enabled = FALSE;
+}
+
+void telephony_event_reporting_req(void *telephony_device, int ind)
+{
+	events_enabled = ind == 1 ? TRUE : FALSE;
+
+	telephony_event_reporting_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_response_and_hold_req(void *telephony_device, int rh)
+{
+	response_and_hold = rh;
+
+	telephony_response_and_hold_ind(response_and_hold);
+
+	telephony_response_and_hold_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_last_dialed_number_req(void *telephony_device)
+{
+	debug("telephony-fso: last dialed number request");
+
+	if (last_dialed_number)
+		telephony_dial_number_req(telephony_device, last_dialed_number);
+	else
+		telephony_last_dialed_number_rsp(telephony_device,
+				CME_ERROR_NOT_ALLOWED);
+}
+
+static int send_method_call(const char *dest, const char *path,
+				const char *interface, const char *method,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, int type, ...)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	va_list args;
+
+	msg = dbus_message_new_method_call(dest, path, interface, method);
+	if (!msg) {
+		error("Unable to allocate new D-Bus %s message", method);
+		return -ENOMEM;
+	}
+
+	va_start(args, type);
+
+	if (!dbus_message_append_args_valist(msg, type, args)) {
+		dbus_message_unref(msg);
+		va_end(args);
+		return -EIO;
+	}
+
+	va_end(args);
+
+	if (!cb) {
+		g_dbus_send_message(connection, msg);
+		return 0;
+	}
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+		error("Sending %s failed", method);
+		dbus_message_unref(msg);
+		return -EIO;
+	}
+
+	dbus_pending_call_set_notify(call, cb, user_data, NULL);
+	dbus_pending_call_unref(call);
+	dbus_message_unref(msg);
+
+	return 0;
+}
+
+void telephony_terminate_call_req(void *telephony_device)
+{
+	struct voice_call *vc;
+	int ret;
+
+	if ((vc = find_vc_with_status(CALL_STATUS_ACTIVE))) {
+	} else if ((vc = find_vc_with_status(CALL_STATUS_DIALING))) {
+	} else if ((vc = find_vc_with_status(CALL_STATUS_INCOMING))) {
+	}
+
+	if (!vc) {
+		error("in telephony_terminate_call_req, no active call");
+		telephony_terminate_call_rsp(telephony_device,
+					CME_ERROR_NOT_ALLOWED);
+		return;
+	}
+
+	ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+					FSO_GSMC_INTERFACE,
+					"Release", NULL, NULL,
+					DBUS_TYPE_INT32, &vc->call_index,
+					DBUS_TYPE_INVALID);
+
+	if (ret < 0) {
+		telephony_terminate_call_rsp(telephony_device,
+					CME_ERROR_AG_FAILURE);
+	} else
+		telephony_terminate_call_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_answer_call_req(void *telephony_device)
+{
+	int ret;
+	struct voice_call *vc = find_vc_with_status(CALL_STATUS_INCOMING);
+
+	if (!vc) {
+		telephony_answer_call_rsp(telephony_device,
+					CME_ERROR_NOT_ALLOWED);
+		return;
+	}
+
+	ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+                                        FSO_GSMC_INTERFACE,
+					"Activate", NULL, NULL,
+					DBUS_TYPE_INT32, &vc->call_index,
+					DBUS_TYPE_INVALID);
+
+	if (ret < 0) {
+		telephony_answer_call_rsp(telephony_device,
+					CME_ERROR_AG_FAILURE);
+	} else
+		telephony_answer_call_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_dial_number_req(void *telephony_device, const char *number)
+{
+	const char *clir, *call_type = "voice";
+	int ret;
+
+	debug("telephony-fso: dial request to %s", number);
+
+#if 0
+	if (!strncmp(number, "*31#", 4)) {
+		number += 4;
+		clir = "enabled";
+	} else if (!strncmp(number, "#31#", 4)) {
+		number += 4;
+		clir =  "disabled";
+	} else
+		clir = "default";
+#endif
+	ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+			FSO_GSMC_INTERFACE,
+			"Initiate", NULL, NULL,
+			DBUS_TYPE_STRING, &number,
+			DBUS_TYPE_STRING, &call_type,
+			DBUS_TYPE_INVALID);
+
+	if (ret < 0)
+		telephony_dial_number_rsp(telephony_device,
+			CME_ERROR_AG_FAILURE);
+	else
+		telephony_dial_number_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_transmit_dtmf_req(void *telephony_device, char tone)
+{
+	char *tone_string;
+	int ret;
+
+	debug("telephony-fso: transmit dtmf: %c", tone);
+
+	tone_string = g_strdup_printf("%c", tone);
+	ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+						FSO_GSMC_INTERFACE,
+						"SendDtmf", NULL, NULL,
+						DBUS_TYPE_STRING, &tone_string,
+						DBUS_TYPE_INVALID);
+	g_free(tone_string);
+
+	if (ret < 0)
+		telephony_transmit_dtmf_rsp(telephony_device,
+			CME_ERROR_AG_FAILURE);
+	else
+		telephony_transmit_dtmf_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_subscriber_number_req(void *telephony_device)
+{
+	debug("telephony-fso: subscriber number request");
+
+	if (subscriber_number)
+		telephony_subscriber_number_ind(subscriber_number,
+						NUMBER_TYPE_TELEPHONY,
+						SUBSCRIBER_SERVICE_VOICE);
+	telephony_subscriber_number_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_list_current_calls_req(void *telephony_device)
+{
+	GSList *l;
+	int i;
+
+	debug("telephony-fso: list current calls request");
+
+	for (l = calls, i = 1; l != NULL; l = l->next, i++) {
+		struct voice_call *vc = l->data;
+		int direction;
+
+		direction = vc->originating ?
+				CALL_DIR_OUTGOING : CALL_DIR_INCOMING;
+
+		telephony_list_current_call_ind(i, direction, vc->status,
+					CALL_MODE_VOICE, CALL_MULTIPARTY_NO,
+					vc->number, NUMBER_TYPE_TELEPHONY);
+	}
+	telephony_list_current_calls_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_operator_selection_req(void *telephony_device)
+{
+	debug("telephony-fso: operator selection request");
+
+	telephony_operator_selection_ind(OPERATOR_MODE_AUTO,
+				net.operator_name ? net.operator_name : "");
+	telephony_operator_selection_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_call_hold_req(void *telephony_device, const char *cmd)
+{
+	debug("telephony-fso: got call hold request %s", cmd);
+	telephony_call_hold_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
+{
+	debug("telephony-fso: got %s NR and EC request",
+			enable ? "enable" : "disable");
+
+	telephony_nr_and_ec_rsp(telephony_device, CME_ERROR_NONE);
+}
+
+void telephony_key_press_req(void *telephony_device, const char *keys)
+{
+	struct voice_call *vc;
+	int err=0;
+	char *cmd = NULL, *act="Activate", *rel="Release";
+
+	debug("telephony-fso: got key press request for %s", keys);
+
+	if (vc = find_vc_with_status(CALL_STATUS_INCOMING)) 
+		cmd = act;
+	else if (vc = find_vc_with_status(CALL_STATUS_ACTIVE)) 
+		cmd = rel;
+	else if (vc = find_vc_with_status(CALL_STATUS_DIALING)) 
+		cmd = rel;
+
+	if (cmd) {
+		err = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+					FSO_GSMC_INTERFACE,
+					cmd, NULL, NULL,
+					DBUS_TYPE_INT32, &vc->call_index,
+					DBUS_TYPE_INVALID);
+	}
+	if (err < 0)
+		telephony_key_press_rsp(telephony_device, CME_ERROR_AG_FAILURE);
+	else
+		telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
+
+}
+
+
+void telephony_voice_dial_req(void *telephony_device, gboolean enable)
+{
+	debug("telephony-fso: got %s voice dial request",
+			enable ? "enable" : "disable");
+
+	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
+static void retrieve_entry_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	const char *name, *number;
+	char **number_type = user_data;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	if (reply_check_error(&err, reply))
+		goto done;
+
+	if (!dbus_message_get_args(reply, NULL,
+				DBUS_TYPE_STRING, &name,
+				DBUS_TYPE_STRING, &number,
+				DBUS_TYPE_INVALID))
+		goto done;
+
+	if (number_type == &subscriber_number) {
+		g_free(subscriber_number);
+		subscriber_number = g_strdup(number);
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void retrieve_phonebook_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+	int ret;
+	char * info;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	if (reply_check_error(&err, reply)) {
+		ret = -1;
+		goto done;
+	}
+
+	dbus_message_iter_init(reply, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		error("Unexpected signature in retrieve phonebook reply");
+		ret = -1;
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_INVALID) {
+		DBusMessageIter prop;
+		const char *name, *number;
+		int index;
+
+		dbus_message_iter_recurse(&array, &prop);
+
+		if (!iter_get_basic_args(&prop,
+					DBUS_TYPE_INT32, &index,
+					DBUS_TYPE_STRING, &name,
+					DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_INVALID)) {
+			error("Invalid phonebook entry data");
+			break;
+		}
+		if ((index >= phonebook_info.first) &&
+		    (index <= phonebook_info.last)) {
+			info = g_strdup_printf("%d,\"%s\",,\"%s\"", index,
+								number, name);
+			telephony_phonebook_read_ind(
+					phonebook_info.telephony_device, info);
+			g_free(info);
+		}
+		dbus_message_iter_next(&array);
+	}
+	ret = 0;
+
+done:
+	dbus_message_unref(reply);
+	if (ret)
+		telephony_phonebook_read_rsp(phonebook_info.telephony_device,
+							CME_ERROR_AG_FAILURE);
+	else
+		telephony_phonebook_read_rsp(phonebook_info.telephony_device,
+							CME_ERROR_NONE);
+}
+
+static void get_phonebook_info_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	DBusMessageIter iter, iter_entry, array;
+	int ret;
+	int min_index = -1, max_index = -1;
+	int number_length = -1, name_length = -1;
+	char *info;
+	const char *error_text =
+			"**** Unexpected signature in get phonebook info reply";
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	if (reply_check_error(&err, reply)) {
+		ret = -1;
+		goto done;
+	}
+
+	dbus_message_iter_init(reply, &iter);
+
+	/* ARRAY -> ENTRY -> VARIANT*/
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		error(error_text);
+		ret = -1;
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter, &iter_entry);
+
+	if (dbus_message_iter_get_arg_type(&iter_entry)
+					!= DBUS_TYPE_DICT_ENTRY) {
+		error(error_text);
+		ret = -1;
+		goto done;
+	}
+
+	while (dbus_message_iter_get_arg_type(&iter_entry)
+						!= DBUS_TYPE_INVALID) {
+		DBusMessageIter iter_property, sub;
+		char *property;
+
+		dbus_message_iter_recurse(&iter_entry, &iter_property);
+		if (dbus_message_iter_get_arg_type(&iter_property)
+					!= DBUS_TYPE_STRING) {
+			error(error_text);
+			ret = -1;
+			goto done;
+		}
+
+		dbus_message_iter_get_basic(&iter_property, &property);
+
+		dbus_message_iter_next(&iter_property);
+		dbus_message_iter_recurse(&iter_property, &sub);
+
+		if (g_str_equal(property, "min_index"))
+			dbus_message_iter_get_basic(&sub, &min_index);
+		else if (g_str_equal(property, "max_index"))
+			dbus_message_iter_get_basic(&sub, &max_index);
+		else if (g_str_equal(property, "number_length"))
+			dbus_message_iter_get_basic(&sub, &number_length);
+		else if (g_str_equal(property, "name_length"))
+			dbus_message_iter_get_basic(&sub, &name_length);
+
+		dbus_message_iter_next(&iter_entry);
+	}
+
+	info = g_strdup_printf("\"(%d-%d)\",%d,%d", min_index,max_index,
+		(number_length != -1) ? number_length : 0,
+		(name_length != -1) ? name_length : 0);
+
+	telephony_phonebook_read_ind(phonebook_info.telephony_device, info);
+	g_free(info);
+	ret = 0;
+
+done:
+	dbus_message_unref(reply);
+	if (ret)
+		telephony_phonebook_read_rsp(phonebook_info.telephony_device,
+							CME_ERROR_AG_FAILURE);
+	else
+		telephony_phonebook_read_rsp(phonebook_info.telephony_device,
+							CME_ERROR_NONE);
+
+}
+
+static void get_phonebook_storage_info_reply(DBusPendingCall *call,
+							void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	int used, total;
+	GString *gstr;
+	char *str;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	if (reply_check_error(&err, reply))
+		goto done;
+
+	if (!dbus_message_get_args(reply, NULL, DBUS_TYPE_INT32, &used,
+						DBUS_TYPE_INT32, &total,
+						DBUS_TYPE_INVALID))
+		goto done;
+
+	gstr = g_string_new("");
+	g_string_append_printf(gstr, "%s,%d,%d",
+				gsm_categories[phonebook_info.category],
+				used, total);
+	str = g_string_free(gstr, FALSE);
+	telephony_phonebook_storage_ind(phonebook_info.telephony_device, str);
+	g_free(str);
+	telephony_phonebook_storage_rsp(phonebook_info.telephony_device,
+							CME_ERROR_NONE);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void list_phonebooks_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	DBusMessageIter iter, iter_entry, array;
+	int ret;
+	char **s, *str;
+	int i, num_strings, index;
+	GString *gstr;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	if (reply_check_error(&err, reply)) {
+		ret = -1;
+		goto done;
+	}
+
+	dbus_message_iter_init(reply, &iter);
+
+	dbus_error_init(&err);
+
+	if (!dbus_message_get_args(reply, &err,
+		DBUS_TYPE_ARRAY, DBUS_TYPE_STRING, &s, &num_strings,
+		DBUS_TYPE_INVALID)) {
+		error("dbus_message_get_args replied with an error: %s, %s",
+			err.name, err.message);
+		dbus_error_free(&err);
+		ret = -1;
+		goto done;
+	}
+
+	gstr = g_string_new("(");
+	for (i = 0; i < num_strings; i++) {
+		index = find_category(fso_categories, s[i]);
+		if (index == -1)
+			continue;
+		debug("GSM %d: %s", index, gsm_categories[index]);
+		if (i == 0)
+			g_string_append_printf(gstr, "%s",
+							gsm_categories[index]);
+		else
+			g_string_append_printf(gstr, ",%s",
+							gsm_categories[index]);
+	}
+	g_string_append(gstr, ")");
+	str = g_string_free(gstr, FALSE);
+	telephony_phonebook_storage_ind(phonebook_info.telephony_device, str);
+	g_free(str);
+	dbus_free_string_array(s);
+	ret = 0;
+
+done:
+	dbus_message_unref(reply);
+	if (ret)
+		telephony_phonebook_read_rsp(phonebook_info.telephony_device,
+							CME_ERROR_AG_FAILURE);
+	else
+		telephony_phonebook_read_rsp(phonebook_info.telephony_device,
+							CME_ERROR_NONE);
+}
+
+void telephony_phonebook_storage_req(void *telephony_device,
+					const char *storage, int AT_type)
+{
+	int ret = 0, index;
+
+	debug("telephony-fso: got phonebook storage request %d", AT_type);
+
+	phonebook_info.telephony_device = telephony_device;
+
+	switch (AT_type) {
+	case AT_TEST:      /* =? */
+		ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+						FSO_SIM_INTERFACE,
+						"ListPhonebooks",
+						list_phonebooks_reply, NULL,
+						DBUS_TYPE_INVALID);
+		break;
+	case AT_READ:       /* ? */
+		ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+				FSO_SIM_INTERFACE,
+				"GetPhonebookStorageInfo",
+				get_phonebook_storage_info_reply, NULL,
+				DBUS_TYPE_STRING,
+				&fso_categories[phonebook_info.category],
+				DBUS_TYPE_INVALID);
+		break;
+	case AT_SET:         /* = */
+		debug("Phonebook request to be %s", storage);
+		index = find_category(gsm_categories, storage);
+		debug("Phonebook found at %d", index);
+		if (index == -1)
+			ret = -1;
+		else {
+			phonebook_info.category = index;
+			telephony_phonebook_storage_rsp(telephony_device,
+								CME_ERROR_NONE);
+		}
+		break;
+	default:
+		ret = -1;
+	}
+
+	if (ret < 0)
+		telephony_phonebook_storage_rsp(telephony_device,
+							CME_ERROR_AG_FAILURE);
+}
+
+void telephony_phonebook_read_req(void *telephony_device, const char *readindex,
+								int AT_type)
+{
+	int size, ret=0;
+	debug("telephony-fso: got pbook read request: %s", readindex);
+
+	phonebook_info.telephony_device = telephony_device;
+
+	switch (AT_type) {
+	case AT_TEST:          /* =? */
+		ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+				FSO_SIM_INTERFACE,
+				"GetPhonebookInfo",
+				get_phonebook_info_reply, NULL,
+				DBUS_TYPE_STRING,
+				&fso_categories[phonebook_info.category],
+				DBUS_TYPE_INVALID);
+		break;
+
+	case AT_READ:          /* ? */
+		ret = -1;
+		break;
+
+	case AT_SET:            /* = */
+		phonebook_info.first = -1, phonebook_info.last = -1;
+		sscanf(readindex, "%d,%d", &phonebook_info.first,
+							&phonebook_info.last);
+		if (phonebook_info.first == -1)
+			break;
+
+		if (phonebook_info.last == -1)
+			phonebook_info.last = phonebook_info.first;
+
+		ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+				FSO_SIM_INTERFACE,
+				"RetrievePhonebook",
+				retrieve_phonebook_reply, NULL,
+				DBUS_TYPE_STRING,
+				&fso_categories[phonebook_info.category],
+				DBUS_TYPE_INT32, &phonebook_info.first,
+				DBUS_TYPE_INT32, &phonebook_info.last,
+				DBUS_TYPE_INVALID);
+		break;
+
+	default:
+		ret = -1;
+	}
+
+	if (ret < 0)
+		telephony_phonebook_read_rsp(telephony_device,
+							CME_ERROR_AG_FAILURE);
+}
+
+static void parse_gsmcall_property(const char *property, DBusMessageIter sub,
+							struct voice_call *vc)
+{
+	const char *direction, *peer, *reason, *auxstatus, *line;
+
+	if (g_str_equal(property, "direction")) {
+		dbus_message_iter_get_basic(&sub, &direction);
+	} else if (g_str_equal(property, "peer")) {
+		dbus_message_iter_get_basic(&sub, &peer);
+		vc->number = g_strdup(peer);
+	} else if (g_str_equal(property, "reason")) {
+		dbus_message_iter_get_basic(&sub, &reason);
+	} else if (g_str_equal(property, "auxstatus")) {
+		dbus_message_iter_get_basic(&sub, &auxstatus);
+	} else if (g_str_equal(property, "line")) {
+		dbus_message_iter_get_basic(&sub, &line);
+	}
+}
+
+static gboolean handle_gsmcall_property_changed(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter, iter_entry, array;
+	const char *status;
+	struct voice_call *vc;
+	dbus_int32_t call_index;
+	const char *error_text =
+		"Unexpected signature in gsmcall PropertyChanged signal";
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INT32) {
+		error(error_text);
+		return TRUE;
+	}
+
+	dbus_message_iter_get_basic(&iter, &call_index);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
+		error(error_text);
+		return TRUE;
+	}
+
+	dbus_message_iter_get_basic(&iter, &status);
+
+	debug("**** gsmProp Changed id:%d status: %s", call_index, status);
+
+	vc = find_vc(call_index);
+	if (!vc) {
+		vc = g_new0(struct voice_call, 1);
+		vc->call_index = call_index;
+		calls = g_slist_append(calls, vc);
+	}
+
+	dbus_message_iter_next(&iter);
+
+	/* array -> entry -> sv */
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		error(error_text);
+		return TRUE;
+	}
+
+	dbus_message_iter_recurse(&iter, &iter_entry);
+
+	if (dbus_message_iter_get_arg_type(&iter_entry)
+						!= DBUS_TYPE_DICT_ENTRY) {
+		error(error_text);
+		return TRUE;
+	}
+
+	while (dbus_message_iter_get_arg_type(&iter_entry)
+							!= DBUS_TYPE_INVALID) {
+		DBusMessageIter iter_property, sub;
+		char *property;
+
+		dbus_message_iter_recurse(&iter_entry, &iter_property);
+		if (dbus_message_iter_get_arg_type(&iter_property)
+							!= DBUS_TYPE_STRING) {
+			error(error_text);
+			return TRUE;
+		}
+
+		dbus_message_iter_get_basic(&iter_property, &property);
+
+		dbus_message_iter_next(&iter_property);
+		dbus_message_iter_recurse(&iter_property, &sub);
+
+		parse_gsmcall_property(property, sub, vc);
+
+		dbus_message_iter_next(&iter_entry);
+	}
+
+	if (g_str_equal(status, "incoming")) {
+		/* state change from waiting to incoming */
+		vc->status = CALL_STATUS_INCOMING;
+		vc->originating = FALSE;
+		telephony_update_indicator(fso_indicators, "callsetup",
+				EV_CALLSETUP_INCOMING);
+		telephony_incoming_call_ind(vc->number, NUMBER_TYPE_TELEPHONY);
+		debug("vc status is CALL_STATUS_INCOMING");
+	} else if (g_str_equal(status, "outgoing")) {
+		vc->status = CALL_STATUS_DIALING;
+		vc->originating = TRUE;
+		g_free(last_dialed_number);
+		last_dialed_number = g_strdup(vc->number);
+		telephony_update_indicator(fso_indicators, "callsetup",
+						EV_CALLSETUP_OUTGOING);
+	} else if (g_str_equal(status, "active")) {
+		telephony_update_indicator(fso_indicators,
+					"call", EV_CALL_ACTIVE);
+		telephony_update_indicator(fso_indicators,
+					"callsetup", EV_CALLSETUP_INACTIVE);
+		if (vc->status == CALL_STATUS_INCOMING) {
+			telephony_calling_stopped_ind();
+		}
+		vc->status = CALL_STATUS_ACTIVE;
+		debug("vc status is CALL_STATUS_ACTIVE");
+	} else if (g_str_equal(status, "held")) {
+		vc->status = CALL_STATUS_HELD;
+	} else if (g_str_equal(status, "release")) {
+		printf("in disconnected case\n");
+		if (vc->status == CALL_STATUS_ACTIVE)
+			telephony_update_indicator(fso_indicators,
+				"call", EV_CALL_INACTIVE);
+		else
+			telephony_update_indicator(fso_indicators,
+				"callsetup", EV_CALLSETUP_INACTIVE);
+		if (vc->status == CALL_STATUS_INCOMING)
+			telephony_calling_stopped_ind();
+		calls = g_slist_remove(calls, vc);
+		vc_free(vc);
+	}
+	return TRUE;
+}
+
+static void parse_registration_property(const char *property,
+							DBusMessageIter sub)
+{
+	const char *status, *operator;
+	unsigned int signals_bar;
+
+	if (g_str_equal(property, "registration")) {
+		dbus_message_iter_get_basic(&sub, &status);
+		debug("registration is %s", status);
+		if (g_str_equal(status, "home")) {
+			net.status = NETWORK_REG_STATUS_HOME;
+			telephony_update_indicator(fso_indicators,
+						"roam", EV_ROAM_INACTIVE);
+			telephony_update_indicator(fso_indicators,
+						"service", EV_SERVICE_PRESENT);
+		} else if (g_str_equal(status, "roaming")) {
+			net.status = NETWORK_REG_STATUS_ROAM;
+			telephony_update_indicator(fso_indicators,
+						"roam", EV_ROAM_ACTIVE);
+			telephony_update_indicator(fso_indicators,
+						"service", EV_SERVICE_PRESENT);
+		} else {
+			net.status = NETWORK_REG_STATUS_UNREGISTERED;
+			telephony_update_indicator(fso_indicators,
+						"roam", EV_ROAM_INACTIVE);
+			telephony_update_indicator(fso_indicators,
+						"service", EV_SERVICE_NONE);
+		}
+	} else if (g_str_equal(property, "provider")) {
+		dbus_message_iter_get_basic(&sub, &operator);
+		debug("Operator is %s", operator);
+		g_free(net.operator_name);
+		net.operator_name = g_strdup(operator);
+	} else if (g_str_equal(property, "strength")) {
+		dbus_message_iter_get_basic(&sub, &signals_bar);
+		debug("SignalStrength is %d", signals_bar);
+		net.signals_bar = signals_bar;
+		telephony_update_indicator(fso_indicators, "signal",
+						(signals_bar + 20) / 21);
+	}
+}
+
+static gboolean handle_registration_property(DBusMessage *msg)
+{
+	DBusMessageIter iter, iter_entry;
+	const char *property;
+
+	dbus_message_iter_init(msg, &iter);
+
+	/* ARRAY -> ENTRY -> VARIANT */
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		error("**** Unexpected signature in GetProperties return");
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter, &iter_entry);
+
+	if (dbus_message_iter_get_arg_type(&iter_entry)
+					!= DBUS_TYPE_DICT_ENTRY) {
+		error("**** Unexpected signature in GetProperties return");
+		goto done;
+	}
+
+	while (dbus_message_iter_get_arg_type(&iter_entry)
+					!= DBUS_TYPE_INVALID) {
+		DBusMessageIter iter_property, sub;
+		char *property;
+
+		dbus_message_iter_recurse(&iter_entry, &iter_property);
+		if (dbus_message_iter_get_arg_type(&iter_property)
+					!= DBUS_TYPE_STRING) {
+			error("Unexpected signature in GetProperties return");
+			goto done;
+		}
+
+		dbus_message_iter_get_basic(&iter_property, &property);
+
+		dbus_message_iter_next(&iter_property);
+		dbus_message_iter_recurse(&iter_property, &sub);
+
+		parse_registration_property(property, sub);
+
+		dbus_message_iter_next(&iter_entry);
+	}
+
+done:
+	return TRUE;
+}
+
+
+static void get_registration_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	DBusMessageIter iter, iter_entry;
+	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
+				AG_FEATURE_REJECT_A_CALL |
+				AG_FEATURE_ENHANCED_CALL_STATUS |
+				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	if (reply_check_error(&err, reply)) {
+		goto done;
+	}
+
+	handle_registration_property(reply);
+
+	telephony_ready_ind(features, fso_indicators,
+				response_and_hold, chld_str);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static gboolean handle_registration_property_changed(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return handle_registration_property(msg);
+}
+
+static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply;
+	DBusError err;
+	dbus_int32_t level;
+	int *value = user_data;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	if (reply_check_error(&err, reply))
+		goto done;
+
+	dbus_message_get_args(reply, NULL,
+				DBUS_TYPE_INT32, &level,
+				DBUS_TYPE_INVALID);
+
+	*value = (int) level;
+
+	if (value == &battchg_last)
+		debug("telephony-fso: battery.charge_level.last_full"
+					" is %d", *value);
+	else if (value == &battchg_design)
+		debug("telephony-fso: battery.charge_level.design"
+					" is %d", *value);
+	else
+		debug("telephony-fso: battery.charge_level.current"
+					" is %d", *value);
+
+	if ((battchg_design > 0 || battchg_last > 0) && battchg_cur >= 0) {
+		int new, max;
+
+		if (battchg_last > 0)
+			max = battchg_last;
+		else
+			max = battchg_design;
+
+		new = battchg_cur * 5 / max;
+
+		telephony_update_indicator(fso_indicators, "battchg", new);
+	}
+done:
+	dbus_message_unref(reply);
+}
+
+static void hal_get_integer(const char *path, const char *key, void *user_data)
+{
+	send_method_call("org.freedesktop.Hal", path,
+			"org.freedesktop.Hal.Device",
+			"GetPropertyInteger",
+			hal_battery_level_reply, user_data,
+			DBUS_TYPE_STRING, &key,
+			DBUS_TYPE_INVALID);
+}
+
+static gboolean handle_hal_property_modified(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	const char *path;
+	DBusMessageIter iter, array;
+	dbus_int32_t num_changes;
+
+	path = dbus_message_get_path(msg);
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INT32) {
+		error("Unexpected signature in hal PropertyModified signal");
+		return TRUE;
+	}
+
+	dbus_message_iter_get_basic(&iter, &num_changes);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		error("Unexpected signature in hal PropertyModified signal");
+		return TRUE;
+	}
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_INVALID) {
+		DBusMessageIter prop;
+		const char *name;
+		dbus_bool_t added, removed;
+
+		dbus_message_iter_recurse(&array, &prop);
+
+		if (!iter_get_basic_args(&prop,
+					DBUS_TYPE_STRING, &name,
+					DBUS_TYPE_BOOLEAN, &added,
+					DBUS_TYPE_BOOLEAN, &removed,
+					DBUS_TYPE_INVALID)) {
+			error("Invalid hal PropertyModified parameters");
+			break;
+		}
+
+		if (g_str_equal(name, "battery.charge_level.last_full"))
+			hal_get_integer(path, name, &battchg_last);
+		else if (g_str_equal(name, "battery.charge_level.current"))
+			hal_get_integer(path, name, &battchg_cur);
+		else if (g_str_equal(name, "battery.charge_level.design"))
+			hal_get_integer(path, name, &battchg_design);
+
+		dbus_message_iter_next(&array);
+	}
+
+	return TRUE;
+}
+
+static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply;
+	DBusError err;
+	DBusMessageIter iter, sub;
+	int type;
+	const char *path;
+
+	debug("begin of hal_find_device_reply()");
+	reply = dbus_pending_call_steal_reply(call);
+
+
+	if (reply_check_error(&err, reply)) {
+		goto done;
+	}
+
+	dbus_message_iter_init(reply, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		error("Unexpected signature in hal_find_device_reply()");
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter, &sub);
+
+	type = dbus_message_iter_get_arg_type(&sub);
+
+	if (type != DBUS_TYPE_OBJECT_PATH && type != DBUS_TYPE_STRING) {
+		error("No hal device with battery capability found");
+		goto done;
+	}
+
+	dbus_message_iter_get_basic(&sub, &path);
+
+	debug("telephony-fso: found battery device at %s", path);
+
+	device_watch = g_dbus_add_signal_watch(connection, NULL, path,
+					"org.freedesktop.Hal.Device",
+					"PropertyModified",
+					handle_hal_property_modified,
+					NULL, NULL);
+
+	hal_get_integer(path, "battery.charge_level.last_full", &battchg_last);
+	hal_get_integer(path, "battery.charge_level.current", &battchg_cur);
+	hal_get_integer(path, "battery.charge_level.design", &battchg_design);
+
+done:
+	dbus_message_unref(reply);
+}
+
+int telephony_init(void)
+{
+	const char *battery_cap = "battery";
+	dbus_uint32_t first_index = 1;
+	int ret;
+
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	registration_watch = g_dbus_add_signal_watch(connection, NULL, NULL,
+					FSO_NETWORKREG_INTERFACE,
+					"Status",
+					handle_registration_property_changed,
+					NULL, NULL);
+
+	voice_watch = g_dbus_add_signal_watch(connection, NULL, NULL,
+					FSO_GSMC_INTERFACE,
+					"CallStatus",
+					handle_gsmcall_property_changed,
+					NULL, NULL);
+
+	ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+			FSO_NETWORKREG_INTERFACE,
+			"GetStatus", get_registration_reply,
+			NULL, DBUS_TYPE_INVALID);
+
+	if (ret < 0)
+		return ret;
+
+	ret = send_method_call("org.freedesktop.Hal",
+				"/org/freedesktop/Hal/Manager",
+				"org.freedesktop.Hal.Manager",
+				"FindDeviceByCapability",
+				hal_find_device_reply, NULL,
+				DBUS_TYPE_STRING, &battery_cap,
+				DBUS_TYPE_INVALID);
+	if (ret < 0)
+		return ret;
+
+	ret = send_method_call(FSO_BUS_NAME, FSO_MODEM_OBJ_PATH,
+						FSO_SIM_INTERFACE,
+						"RetrieveEntry",
+						retrieve_entry_reply,
+						&subscriber_number,
+						DBUS_TYPE_STRING,
+						&fso_categories[OWN_CATEGORY],
+						DBUS_TYPE_INT32, &first_index,
+						DBUS_TYPE_INVALID);
+	if (ret < 0)
+		return ret;
+
+	debug("telephony_init() successfully");
+
+	return ret;
+}
+
+void telephony_exit(void)
+{
+	g_free(net.operator_name);
+	g_free(last_dialed_number);
+	g_free(subscriber_number);
+
+	g_slist_foreach(calls, (GFunc) vc_free, NULL);
+	g_slist_free(calls);
+	calls = NULL;
+
+	g_dbus_remove_watch(connection, registration_watch);
+	g_dbus_remove_watch(connection, voice_watch);
+	g_dbus_remove_watch(connection, device_watch);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
+
diff --git a/audio/telephony-maemo.c b/audio/telephony-maemo.c
index f7531f3..0d990d1 100644
--- a/audio/telephony-maemo.c
+++ b/audio/telephony-maemo.c
@@ -922,6 +922,16 @@ void telephony_voice_dial_req(void *telephony_device, gboolean enable)
 	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
 }
 
+void telephony_phonebook_read_req(void *telephony_device, const char *readindex, int ATtype)
+{
+        telephony_phonebook_read_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
+void telephony_phonebook_storage_req(void *telephony_device, const char *readindex, int ATtype)
+{
+        telephony_phonebook_storage_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
 static void handle_incoming_call(DBusMessage *msg)
 {
 	const char *number, *call_path;
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 3df76c3..6aedf12 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -387,6 +387,17 @@ void telephony_key_press_req(void *telephony_device, const char *keys)
 	telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
 }
 
+void telephony_phonebook_read_req(void *telephony_device, const char *readindex, int ATtype)
+{
+	telephony_phonebook_read_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
+void telephony_phonebook_storage_req(void *telephony_device, const char *readindex, int ATtype)
+{
+	telephony_phonebook_storage_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
+
 void telephony_voice_dial_req(void *telephony_device, gboolean enable)
 {
 	debug("telephony-ofono: got %s voice dial request",
diff --git a/audio/telephony.h b/audio/telephony.h
index 0bc4769..64d58b5 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -127,6 +127,12 @@ typedef enum {
 	CME_ERROR_NETWORK_NOT_ALLOWED	= 32,
 } cme_error_t;
 
+/* AT command types */
+#define AT_NONE  0
+#define AT_TEST 1
+#define AT_READ 2
+#define AT_SET   3
+
 struct indicator {
 	const char *desc;
 	const char *range;
@@ -157,6 +163,8 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd);
 void telephony_nr_and_ec_req(void *telephony_device, gboolean enable);
 void telephony_voice_dial_req(void *telephony_device, gboolean enable);
 void telephony_key_press_req(void *telephony_device, const char *keys);
+void telephony_phonebook_storage_req(void *telephony_device, const char *storage, int AT_type);
+void telephony_phonebook_read_req(void *telephony_device, const char *readindex, int AT_type);
 
 /* AG responses to HF requests. These are implemented by headset.c */
 int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err);
@@ -173,6 +181,8 @@ int telephony_call_hold_rsp(void *telephony_device, cme_error_t err);
 int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err);
 int telephony_voice_dial_rsp(void *telephony_device, cme_error_t err);
 int telephony_key_press_rsp(void *telephony_device, cme_error_t err);
+int telephony_phonebook_storage_rsp(void *telephony_device, cme_error_t err);
+int telephony_phonebook_read_rsp(void *telephony_device, cme_error_t err);
 
 /* Event indications by AG. These are implemented by headset.c */
 int telephony_event_ind(int index);
@@ -188,6 +198,8 @@ int telephony_subscriber_number_ind(const char *number, int type,
 					int service);
 int telephony_call_waiting_ind(const char *number, int type);
 int telephony_operator_selection_ind(int mode, const char *oper);
+int telephony_phonebook_storage_ind(void *device, const char *storagelist);
+int telephony_phonebook_read_ind(void *device, const char *entrylist);
 
 /* Helper function for quick indicator updates */
 static inline int telephony_update_indicator(struct indicator *indicators,
-- 
1.6.4.2


--=-5zEhbNZNFf6dUFonqOhw--

