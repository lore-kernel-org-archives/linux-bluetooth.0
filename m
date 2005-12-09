Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] UART bluetooth chip problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7846f1440512090957t2f6cd767xc61ae8e19953993e@mail.gmail.com>
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134020677.3752.61.camel@blade>
	 <7846f1440512081019g4bbf588cta4f4d395b7be0d74@mail.gmail.com>
	 <1134074044.17592.13.camel@blade>
	 <7846f1440512081510w4ffff8cdoe25ae369e677144@mail.gmail.com>
	 <1134087822.17592.44.camel@blade>
	 <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
	 <7846f1440512090957t2f6cd767xc61ae8e19953993e@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134153686.10644.12.camel@blade>
Mime-Version: 1.0
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
Date: Fri, 09 Dec 2005 19:41:26 +0100

Hi Arthur,

> I'm not sure if this is what you're looking for when you say build id
> for the chip, but this is what i see when I look at the back of the
> chip: 

the build id is the firmware identifier. It is a uint16 and you also
find it as HCI Revision or LMP Subversion in case of a CSR chip.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
