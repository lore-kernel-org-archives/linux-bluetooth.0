Return-Path: <cyrus@holtmann.org>
From: "Phil Endecott" <spam_from_bluez_users@chezphil.org>
To: <bluez-users@lists.sourceforge.net>
Date: Wed, 23 Apr 2008 20:04:03 +0100
Message-ID: <1208977443694@dmwebmail.dmwebmail.chezphil.org>
In-Reply-To: <5eee8c670804220813m351b6d10l57ad21bd34c812f0@mail.gmail.com>
References: <5eee8c670804220813m351b6d10l57ad21bd34c812f0@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Apple wireless keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Odysseus Flappington wrote:
> You're probably suffering from the following bug:
>
> https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394
>
> Try a 'hciconfig hci0 reset' after restarting and then your keyboard should
> reconnect again.

Thanks for the suggestion.  That bug reporter was seeing "UP RUNNING"
but not scanning in the hciconfig output; I am getting "UP RUNNING
PSCAN ISCAN", so I don't think it's the same thing.

On more investigation, it seems that the failure happens after the
keyboard has gone to sleep and I wake it up; I then see this in syslog:

Apr 23 18:09:37 egypt hidd[2856]: New HID device 00:1E:52:F9:60:2C
(Apple Inc. Keyboard)
Apr 23 18:09:37 egypt kernel: input: Apple Inc. Keyboard as /class/input/input13
Apr 23 18:09:37 egypt kernel: usb 3-2: uhci_result_common: failed with
status 440000
Apr 23 18:09:37 egypt kernel: usb 3-2: uhci_result_common: failed with
status 440000

Does anyone know what "status 440000" is?  It makes me think that it's
a lower level problem with the USB dongle.

After 30 mins I get this, which is presumably related:
Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 ACL tx timeout
Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 killing stalled ACL
connection 2C:60:F9:52:1E:00
Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 ACL tx timeout
Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 killing stalled ACL
connection 2C:60:F9:52:1E:00

I can make the keyboard work again by re-plugging the USB dongle and
waking up the keyboard.

Anyway, I am going to try to get a USB bluetooth dongle that has a HID
proxy mode, and hopefully this can all be avoided.  If anyone can
suggest a particular brand/model that is known to work in HID proxy
mode, please let me know!  Thanks.


Phil.







-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
