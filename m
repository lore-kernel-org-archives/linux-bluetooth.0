Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Date: Tue, 23 Jan 2007 08:40:48 +0100
Message-Id: <200701230840.49172.fernando@bluexare.org>
Subject: Re: [Bluez-devel] About the pairing event
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

Ok, I will try to explain me.

I want to make an application who recognize several events produced from one 
mobile (for example) to other device (in this case, a PC).

I have the control of the PC, and I want to know what kind of event the mobile 
realized.

If the mobile sends a card, or an image, like this event is realized by OBEX, 
I put a listen port with RFCOMM in the channel I'm using OBEX.
Therefore, I can know when one device tryes to send me something.

And I want to recognize the pairing event too.

I think the hcid does this, but I don know how to modify (the code) for my 
necessities.

I have explain me?

Sorry, I don't speak english very well.

Thank you very much.

Fernando Unzu


----------  Mensaje reenviado  ----------

Subject: Re: [Bluez-devel] About the pairing event
Date: Lunes, 22 de Enero de 2007 19:14
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>

On 1/22/07, Fernando Unzu <fernando@bluexare.org> wrote:
> I'm working by searching the mode of caught the pairing event with my PC
> from one mobile.
> Could anybody help me?

Sorry, but I didn't quite understand what you're trying to do. Do you
care to explain so we can help you?

Regards,

-- Ulisses

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
