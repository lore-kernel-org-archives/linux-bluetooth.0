Return-Path: <cyrus@holtmann.org>
Message-ID: <4A95891A.20402@gmail.com>
Date: Wed, 26 Aug 2009 21:12:26 +0200
From: Till Kamppeter <till.kamppeter@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org,
 Mario Limonciello <superm1@ubuntu.com>
Subject: Re: PATCHES: Device discovery of the "bluetooth" CUPS backend does
 not work
References: <4A957819.7040808@gmail.com> <1251310460.2950.98.camel@localhost.localdomain>
In-Reply-To: <1251310460.2950.98.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------010707070002020302050307"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010707070002020302050307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for the quick answer.

Patch in GIT format attached.

    Till


Marcel Holtmann wrote:
> Hi Till,
> 
>> I am using Bluez 4.48 in Ubuntu Karmic. First thank you for applying my 
>> patches. The bluetooth backend works perfectly now with CUPS 1.3.x and 
>> older. On the new CUPS 1.4.x a new problem appeared: The new CUPS does 
>> device discovery only for a given time frame requested by the client 
>> (printer setup tool, "lpinfo" command). CUPS's default for 
>> CUPS-1.3.x-ish requests without timeout specification seems to be 10 
>> seconds. CUPS startys all backends at once in the beginning (in 
>> parallel) and kills every backend which remains running at the end of 
>> the timeout. It accepts output from the backends whenever it occurs not 
>> only when the backend finishes, so a backend can search for printers 
>> infinitely long if it outputs every found device immediately. Then all 
>> printers found during CUPS' timeout are taken into account.
>>
>> The bluetooth backend o 4.48 asks the Bluetooth daemon for printers and 
>> collects results for 10 seconds and after that it output them. This 
>> takes a total of 10.5 sec and so CUPS kills the backend right before it 
>> answers (at least with the 10-second default timeout), resulting in 
>> Bluetooth printers never being discovered by CUPS.
>>
>> I have fixed this now with the attached patch, by making each new 
>> printer added to the list being output immediately. Note that the list 
>> structure cannot be removed from cups/main.c as otherwise we would get 
>> duplicate listings.
>>
>> Can you please apply this patch to Bluez so that Bluez gets ready for 
>> the new CUPS 1.4.x generation? Thanks.
> 
> send a patch created with git format-patch so we can apply them properly
> without me having to modify the commit message manually.
> 
> Regards
> 
> Marcel
> 
> 
> 


--------------010707070002020302050307
Content-Type: text/x-patch;
 name="0001-Make-discovery-mode-of-bluetooth-CUPS-backend-work-w.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Make-discovery-mode-of-bluetooth-CUPS-backend-work-w.pa";
 filename*1="tch"

>From e9f4b0053ca32a17dfff7d19adb521952c45cf61 Mon Sep 17 00:00:00 2001
From: Till Kamppeter <till.kamppeter@gmail.com>
Date: Wed, 26 Aug 2009 21:05:43 +0200
Subject: [PATCH] Make discovery mode of bluetooth CUPS backend work with CUPS 1.4.0.

---
 ChangeLog   |    2 +
 cups/main.c |   63 +++++++++++++++++++++++-----------------------------------
 2 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index d06f494..6c170f6 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,5 @@
+ver 4.51:
+	Make discovery mode of bluetooth CUPS backend work with CUPS 1.4.0.
 ver 4.50:
 	Fix issue with missing manual pages in distribution.
 	Fix issue with the configuration and state directories.
diff --git a/cups/main.c b/cups/main.c
index da757b0..1bbc78c 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -185,6 +185,27 @@ static char *device_get_ieee1284_id(const char *adapter, const char *device)
 	return id;
 }
 
+static void print_printer_details(const char *name, const char *bdaddr, const char *id)
+{
+	char *uri, *escaped;
+
+	escaped = g_strdelimit(g_strdup(name), "\"", '\'');
+	uri = g_strdup_printf("bluetooth://%c%c%c%c%c%c%c%c%c%c%c%c",
+		 bdaddr[0], bdaddr[1],
+		 bdaddr[3], bdaddr[4],
+		 bdaddr[6], bdaddr[7],
+		 bdaddr[9], bdaddr[10],
+		 bdaddr[12], bdaddr[13],
+		 bdaddr[15], bdaddr[16]);
+	printf("direct %s \"%s\" \"%s (Bluetooth)\"", uri, escaped, escaped);
+	if (id != NULL)
+		printf(" \"%s\"\n", id);
+	else
+		printf("\n");
+	g_free(escaped);
+	g_free(uri);
+}
+
 static void add_device_to_list(const char *name, const char *bdaddr, const char *id)
 {
 	struct cups_device *device;
@@ -212,27 +233,7 @@ static void add_device_to_list(const char *name, const char *bdaddr, const char
 	device->id = g_strdup(id);
 
 	device_list = g_slist_prepend(device_list, device);
-}
-
-static void print_printer_details(const char *name, const char *bdaddr, const char *id)
-{
-	char *uri, *escaped;
-
-	escaped = g_strdelimit(g_strdup(name), "\"", '\'');
-	uri = g_strdup_printf("bluetooth://%c%c%c%c%c%c%c%c%c%c%c%c",
-		 bdaddr[0], bdaddr[1],
-		 bdaddr[3], bdaddr[4],
-		 bdaddr[6], bdaddr[7],
-		 bdaddr[9], bdaddr[10],
-		 bdaddr[12], bdaddr[13],
-		 bdaddr[15], bdaddr[16]);
-	printf("direct %s \"%s\" \"%s (Bluetooth)\"", uri, escaped, escaped);
-	if (id != NULL)
-		printf(" \"%s\"\n", id);
-	else
-		printf("\n");
-	g_free(escaped);
-	g_free(uri);
+	print_printer_details(device->name, device->bdaddr, device->id);
 }
 
 static gboolean parse_device_properties(DBusMessageIter *reply_iter, char **name, char **bdaddr)
@@ -384,23 +385,6 @@ static void remote_device_found(const char *adapter, const char *bdaddr, const c
 
 static void discovery_completed(void)
 {
-	GSList *l;
-
-	for (l = device_list; l != NULL; l = l->next) {
-		struct cups_device *device = (struct cups_device *) l->data;
-
-		if (device->name == NULL)
-			device->name = g_strdelimit(g_strdup(device->bdaddr), ":", '-');
-		/* Give another try to getting an ID for the device */
-		if (device->id == NULL)
-			remote_device_found(NULL, device->bdaddr, device->name);
-		print_printer_details(device->name, device->bdaddr, device->id);
-		g_free(device->name);
-		g_free(device->bdaddr);
-		g_free(device->id);
-		g_free(device);
-	}
-
 	g_slist_free(device_list);
 	device_list = NULL;
 
@@ -638,6 +622,9 @@ int main(int argc, char *argv[])
 	/* Make sure status messages are not buffered */
 	setbuf(stderr, NULL);
 
+	/* Make sure output is not buffered */
+	setbuf(stdout, NULL);
+
 	/* Ignore SIGPIPE signals */
 #ifdef HAVE_SIGSET
 	sigset(SIGPIPE, SIG_IGN);
-- 
1.6.3.3


--------------010707070002020302050307--
