Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5f30e261041224131026cfa70a@mail.gmail.com>
From: Jeff Wilson <jazzbotley@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] hciconfig question
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
Date: Fri, 24 Dec 2004 15:10:46 -0600

Hi,

I'm studying hciconfig.c to learn how to set inquiry mode and
parameters.  As I play with the binary to understand the source, I get
the following error on "hciconfig hci0 inqmode":

Can't read inquiry mode on hci0. Input/output error(5)

The "inqparms" command reads from hci0 just fine, with no errors.  I
have "iscan enable" set in /etc/bluetooth/hcid.conf ... what else
should I check?

       Thanks for your time,
         jw


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
