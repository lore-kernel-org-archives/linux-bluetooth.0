Return-Path: <cyrus@holtmann.org>
Message-ID: <478CE7A1.6000603@aircable.net>
Date: Tue, 15 Jan 2008 15:04:33 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <fe53c8c00801150523j4eebbf02p584cf92bdcf9f777@mail.gmail.com>	<478CB508.50904@aircable.net>
	<fe53c8c00801150742x434ff374me04c438955d38932@mail.gmail.com>
In-Reply-To: <fe53c8c00801150742x434ff374me04c438955d38932@mail.gmail.com>
Subject: Re: [Bluez-users] how many BT devices can be connected at the same
 time?
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

You should read the specs a bit.

A dongle is a physical device that you plug to your computer via
different medias like USB, RS232 etc.

Each one of those dongles can manage up to 7 connections, and bluez can
handle up to 15 of those dongles.

Cell phones can handle up to 7 ACL connections (low level), higher
levels connections depends on the cell.

> oh here i got a little confused,
>
> 7 connection for each dongle you mean??.. that means i can connect 15
> different BT devices and  each device can simultaneously have 7
> connections with the Bluez stack??..  My application works on a
> topology with heterogenious BT devices. Mobiles being the lowest
> common denominator. So when i talk specifically about mobiles, I can
> connect 15 mobiles to Bluez with one connection from each(i think
> mobiles cant have more than one connection at any instance of time).
>
>
> If i can get these informations cleared up first, i can continue with
> my interesting venture ;). I am planning to circumvent this
> restriction using multiplexing. I will just let the connections wait,
> till they get free ;). Let me see how it goes. But someone please
> correct if i am still misunderstanding the BT constraints.
>
>
> joel.
>
> On Jan 15, 2008 6:58 PM, Manuel Naranjo <manuel@aircable.net> wrote:
>   
>> Joel,
>> You have 2 maximuns one is because of bluetooth specs the other is
>> because of BlueZ constraints.
>>
>> BlueZ can handle up to 15 (someone correct me if I'm wrong) bluetooth
>> dongles (hci devices).
>>
>> Then you can get up to 7 connections per bluetooth dongles (bluetooth
>> constraint)
>>
>> Cheers,
>> Manuel
>>
>>     
>>> hy all,
>>>
>>> I am doing a project, which requires 'n' simultanious connection,
>>> depending on the users loggin into the facility. I was thinking about
>>> implementing an application level "scheduling" to take care of
>>> multiplexing the request. But is there a limit in bluez?? I have heard
>>> bluethooth has a 6slave+1master rule?? I read the FAQ for bluez..but
>>> it confused me with saying .. "multiple devices can be connected".
>>>
>>> thanks for your time,
>>> joel.
>>>
>>>       
>> -------------------------------------------------------------------------
>> Check out the new SourceForge.net Marketplace.
>> It's the best place to buy or sell services for
>> just about anything Open Source.
>> http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>     
>
>
>
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
