Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Beck <becka-HWo7H@acs.uni-duesseldorf.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] VOIP over Bluetooth-Bluez? Is it possible
Message-ID: <20051201211014.GA7471@acs.uni-duesseldorf.de>
References: <438EFD88.4020506@eridani.co.uk> <HCEOIFALKKLBLJPENPNOAEFKCAAA.khaled@ipbill.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HCEOIFALKKLBLJPENPNOAEFKCAAA.khaled@ipbill.com>
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
Date: Thu, 1 Dec 2005 22:10:14 +0100

Khaled <khaled@ipbill.com> wrote:
> How did you get IP setup over bluetooth?
> What sound configuration did you setup?
> OSS, ALSA?
> I hope this isn't off-the-topic but Im having trouble getting IP to work
> over bluetooth; SCO and ACL come into play 

No. Let's first look at how VoIP works in general


Person 1 <--> Headset <--> PC <--> VoIP-Software <--> Networking-Stack
Interface to Transport network <--> Transport Network <--> all the stuff
backwards to Person 2.

Bluetooth can come into play at two places:

1. Between Headset and PC in case you are using a Bluetooth headset. 
   For this you need
   http://bluetooth-alsa.sourceforge.net/
   It should as well contain a few helpers that make skype play nicely
   with BT headsets like picking up and hanging up with the buttons and
   switching between headset and main sound system.
   I have successfully used this with Skype.

2. Between the Networking-Stack and the Transport Network (usually the
   internet), in case you are using a bluetooth connection to connect to 
   your uplink.
   This is where you need other stuff depending on what your uplink is
   like. E.g. the modem profile if connection via a BT-modem, the
   network stuff, if connecting via antother BT-PC, ...
   I haven't tried this, as I feel BT is inadequate for my bandwidth
   needs.

CU, Andy


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
