Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <db972f43040929233863680ff2@mail.gmail.com>
From: Ricky Soh <rickysoh@gmail.com>
Reply-To: Ricky Soh <rickysoh@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Bluetooth headset enquiries
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 30 Sep 2004 14:38:02 +0800

Dear all,

I would like to clear some doubts about the Bluetooth headset profile.
Please assist in anyway possible.

1. After both the headset and AG (Audio Gateway) are paired, if there
are no need for active communication, the headset will go into PARK
mode but stay in sync with the AG. At this point, is there any
transmission between the devices, or is the headset just purely
listening to the master (AG) for the clock sequence? What is the
rate/frequency that the master sent a signal to the headset to
indicate its clock and frequency sequence at this time?

2. What is the encryption key for SCO packets? Is it the same Kc
derived from the E0 cipher scheme used in encrypting the data files in
data transmission? I heard that different security modes will result
in different Kc length, do you have any details on this and what is
the length of the key?

3. For FHSS in bluetooth, there are 13 different packet types. Which
part of the packet is frequency hopping sequence information attached
to? Is it the access codes, the header or the payload? What is the bit
of this information? Do the slave derive that sequence based on the
data (Master's BD_ADDR and clock) exchanged or the slave gets the
sequence directly from the Master?

Sorry for the lengthy email. Please help if possible. Thanks

Sincerely
Ricky


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
