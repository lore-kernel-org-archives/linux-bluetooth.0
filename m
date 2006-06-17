Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <167599168834.168834167599@fh-wolfenbuettel.de>
References: <167599168834.168834167599@fh-wolfenbuettel.de>
Date: Sat, 17 Jun 2006 12:14:46 +0200
Message-Id: <1150539286.17539.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] sending SAP messages on rfcomm?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Goetz,

> --> using hcidump shows, that the essage is sent in some way,look at end
> of  http://sap.goetzi.de/hci_dump_sap_1st_msg.txt 

in the future you should use "hcidump -X -V", because nobody is going to
decode the HCI commands and events for you by hand.

> I have the feeling i am missing something. Any suggestions? Is "write()"
> the correct way? Do I have to define a new type of packet somewhere
> first? I amlost and my deadline for handing in my project at uni is
> coming closer. Any help appreciated, please.

I don't have a SIM access capable phone and thus I never played with
this profile. And I won't do that until someone donates a SIM access
phone to me.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
