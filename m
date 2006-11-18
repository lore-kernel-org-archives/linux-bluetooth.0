Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061118121407.87181.qmail@web52109.mail.yahoo.com>
Date: Sat, 18 Nov 2006 04:14:07 -0800 (PST)
From: Paolo Casaschi <kazavsky67-news@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] Errors pairing with headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Thanks for the hint.

Tried 
    sudo btsco -v aa:bb:cc:dd:ee:ff

At first, got this reply:
    Error: hwdep next device (hw:0): Operation not permitted
    Error: control open (hw:1): No such device
    Error: Can't find device. Bail

Then, googling a bit, I thught I should load the snd_bt_sco module, after i did that, the btsco -v command above gives me back

    btsco v0.42
    Device is 1:0
    Error: Failed to connect to SDP server: Permission denied
    Assuming channel 2

    Voice setting: 0x0060
    Can't connect RFCOMM channel: Permission denied

What do I miss?

-- Paolo

----

From: Arthur <avandorp <at> gmail.com>

Subject: Re: Errors pairing with headset

Newsgroups: gmane.linux.bluez.user

Date: 2006-11-18 11:43:54 GMT
 (22 minutes ago)




Hi Paolo




Trying to connect to my bluetooth headset on a new Ubuntu Edgy install (have'nt touched any of the /etc/bluetooth/*.conf files)


I looked at https://help.ubuntu.com/community/BluetoothSetup for guidance

When my headseat is in pairing mode, if try

    sudo hidd --search 



I get totally no output, not even the "No devices in range or visible" that I get when the headset is off.

But if I try
      sudo hcitool scan
then my headest is recognized
      aa:bb:cc:dd:ee:ff       BT Headset-12

If I try then
      sudo hidd --connect  aa:bb:cc:dd:ee:ff
I get the error message
    Can't get device information: Permission denied


I've never bothered with the hidd stuff. I do get the same "No
devices..." message for hidd --search with my headset turned on even
though it works just fine.


I've just install the bluez-btsco package (sudo aptitude install bluez-btsco). Try running
btsco -v aa:bb:cc:dd:ee:ff
and  see whether it can connect to your headset. The first time you do this, you should be prompted for the pin.


Good luck

Arthur







-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
