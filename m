Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0512011117i730f7dd0p4ffc099d06a09cb8@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Remote name delay
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 1 Dec 2005 17:17:33 -0200

Hi,

I am developing a standalone application to perform real D-Bus
services tests. The main features are:
1. Running all the time in the systray
2. Handle PIN Request
3. Local adapter configuration
4. Basic operations: Inquiry, Remote name, ...

However I am facing a problem in the RemoteName service when a lot of
inquiry replies is received. My app stores the inquired devices in a
hash table and when the InquiryCompleted signal is received the app
request the name for each device. The "hci_send_req" function is
returning an Input/Output error. Looking the hcidump result, the
"Command Disallowed" error is displayed :(

HCIDUMP:
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x0c ncmd 1
    Error: Command Disallowed
 <<<<<Indicates that the controller is in a state where it can process
this command at this time.>>>>

I noticed the same problem using the hcitool with "--flush" option and
removing the cached device information stored in the directory
"/var/lib/bluetooth".

Trying to fix this problem I did some changes in the hcid dbus
RemoteName using the clock offset and page scan repetition mode.
However I didn't reach significant improvements.
* InquiryResult signal Changes
   - Added clock offset
   - Added pscan_rep_mode
* RemoteName Changes
   - Added clock offset
   - Added pscan_rep_mode

I know that I can retrieve some entries from the file "names" in the
storage directory. But without consider this, how can I reduce the
remote name request time?

Regards,
Claudio
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
