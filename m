Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Steven Singer <steven.singer@csr.com>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCI Event: Connect Complete with Status 09
Message-Id: <20040609212529.6901de52.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <40C74EDD.6060903@csr.com>
References: <20040609185348.65a9f382.Andreas.Gaufer@blue-cell-networks.com>
	<40C74EDD.6060903@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 9 Jun 2004 21:25:29 +0200

Hi Steven,

i hoped that you will jump on this ;)

On Wed, 09 Jun 2004 18:54:37 +0100
Steven Singer <steven.singer@csr.com> wrote:

> Andreas Gaufer wrote:
> > I get into situations where the chip returnes a "Connect Complete" event 
> > with status MAX NUMBER OF CONNECTIONS (0X09) without having open handles.
> 
> How do you get in to this situation? Are you, for example, connecting
> and disconnecting very rapidly (less than 1 second per connection) or

Yes, indeed thats close to what im doing. Not within one secoud but very 
frequently.

> are you resetting the remote end of the link without using a proper
> disconnect?

I dont know the other side and i cant tell more than what im seeing through
bluetooth. An what i see is indeed sometimes far from what the specs say.

> Which CSR firmware version are you using?
> 
hci1:   Type: USB
        BD Address: 00:04:61:81:DD:12 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.14
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

> You might want to grab an HCI log and move this discussion to the CSR
> support newsgroup (access details at http://www.csr.com/forum.htm).
> Read the FAQ for a description of suitable log formats.
> 
> A summary of the times of the commands and events associated with
> creating and disconnecting any previous connections (including the
> statuses and connection handles in all the events) might be shorter than
> a full log.
> 

Ok, ill set up a test case to create the situation. Im happy to put the facts
in the newsgroup. Witch group would be the best ? csr.public.bluecore.firmware ?

Greetings 

Andreas Gaufer




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
