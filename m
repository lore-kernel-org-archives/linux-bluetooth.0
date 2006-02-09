Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fd87b6160602081733j5d439ce1oa3fed18924b3f0f6@mail.gmail.com>
From: John McCabe-Dansted <gmatht@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Re: rmmoding snd-bt-sco (so we can hibernate)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 9 Feb 2006 14:33:09 +1300

On 2/9/06, John McCabe-Dansted <gmatht@gmail.com> wrote:
> Is there anyway to rmmod snd-bt-sco when it claims that it is in use?
> (So e.g. I can hibernate). I have tried killall btsco and physically
> removing the usb bluetooth card but the kernel still claims it is in
> use.

Ah, kmix was locking the kernel module snd_bt_sco. For Kubuntu 5.10
"Breezy" it appears to be sufficient to add

  killall kmix
  killall btsco
  rmmod -w snd_bt_sco &

to the beginning of /usr/sbin/hibernate, to allow use of Suspend2 in
conjunction with bluez. BTW, I am not sure that the "killall btsco"
line is neccesary. It doesn't seem to be, but I don't see how btsco
can function without locking the kernel module if even kmix cannot.

--
John C. McCabe-Dansted
Master's Student


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
