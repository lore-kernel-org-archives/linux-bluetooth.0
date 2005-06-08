Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42A731E9.8050703@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Re: UART based bluetooth dongle
References: <Pine.LNX.4.33.0506080804580.23077-100000@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.33.0506080804580.23077-100000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 08 Jun 2005 11:59:05 -0600

Guys,

fwiw, I just ordered two class 1 module samples from 
avantwave/auto-system and I'll let you know how it goes. (they offer 
several firmware options including the h4 hci interface i asked for)

brad

Peter Wippich wrote:
> Hi Gabriel,
> 
> if you realy need access to L2CAP / SDP and RFCOMM (I don't have any idea
> wy you need L2CAP access ....) you should look at CSR based devices and
> use their DevKits for host applications (its not relay cheap...). This
> will give you access to all layers. You may also use an OnChip application
> and only implement access to the realy required funtions.
> 
> I don't know if similar DevKits are available from other Chip vendors
> (e.g. Zeevo).
> 
> Ciao,
> 
> Peter
> 
>  On Fri, 3 Jun 2005, Gabriel Marques wrote:
> 
> 
>>Hi Peter, thanks for the suggestion, but one of the project requirements
>>is that the SDP, L2CAP and part of the RFCOMM would be available to the
>>Java applications (accordingly to JSR82).
>>I'm not sure if that is possible with dongles with integrated RFCOMM,
>>those are serial cables replacements right?
>>I think it would be hard to talk to one of those in a cell phone midlet.
>>
>>And sorry if that is not the appropriate list, but ive already tryed to
>>post this question at 'Sun Java Forums - Bluetooth' and at
>>'Bluetooth.org - RFCOMM' with no answers.
>>Do you know any forum that can help me on this?
>>
>>
>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by Yahoo.
>>Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
>>Search APIs Find out how you can build Yahoo! directly into your own
>>Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
>>_______________________________________________
>>Bluez-devel mailing list
>>Bluez-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
> 
> 
> |	Peter Wippich 			Voice: +49 30 46776411		|
> |	G&W Instruments GmbH		fax:   +49 30 46776419		|
> |	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
> |	D-13355 Berlin  / Germany					|
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
> a projector? How fast can you ride your desk chair down the office luge track?
> If you want to score the big prize, get to know the little guy.  
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
