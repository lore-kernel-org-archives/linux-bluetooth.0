Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.22.19.24.42.369346@yahoo.com>
References: <41F0EB0A.1020302@webstuhl.net> <41F0FE84.8030401@dark-reality.de> <41F128F4.2020006@webstuhl.net> <41F13638.1080207@dark-reality.de> <41F25C4B.6040709@webstuhl.net> <pan.2005.01.22.15.35.18.929419@yahoo.com> <41F290CB.9010504@webstuhl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: Re: Again: Problems with Dongle, Headset or btsco
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
Date: Sat, 22 Jan 2005 21:24:43 +0200

On Sat, 22 Jan 2005 18:43:39 +0100, Ben Pezzei wrote:

> Hi ,
> 
> Paul Ionescu schrieb:
> 
>> How do you know the dongle can't be re-initialized ? What does it say
>> when you launch again btsco ?
> 
> After disconnecting via Headset (press Button) and connecting again the
> btsco looks like:
>    disconnected SCO channel
>    recieved AT+CKPD=200
>    opened hwdep
>    Can't connect SCO audio channel
>    : Connection timed out

you can try to disconnect btsco (with ^C)
verify with
hcitool con
that you don't have any connections still active after you disconnect
btsco, (if they are, delete them with hictool dc MAC_OF_HEADSET)
and then try again to connect with btsco.

I had this problem and I solved this way.

> Same when exiting ctrl+c btsco and start it again
> 
>> I was able to use gnomemeeting, mplayer and other programs that use alsa
>> or oss.
>> For mplayer I used -ao alsa:device=hw=Headset -srate 8000 -channels 1
> 
> no X installed ;(

You don't need X for mplayer




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
