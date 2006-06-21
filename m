Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606202248t48d5e85fi4888304c70f12139@mail.gmail.com>
Date: Wed, 21 Jun 2006 11:18:16 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44986D90.2090505@fh-wolfenbuettel.de>
MIME-Version: 1.0
References: <mailman.1467.1150830573.9417.bluez-devel@lists.sourceforge.net>
	<44986D90.2090505@fh-wolfenbuettel.de>
Subject: Re: [Bluez-devel] blueZ and SAP
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1701323698=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1701323698==
Content-Type: multipart/alternative;
	boundary="----=_Part_51109_15446595.1150868896673"

------=_Part_51109_15446595.1150868896673
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Goetz,


On 6/21/06, Goetz Issel <g.issel@fh-wolfenbuettel.de> wrote:
>
> Hi Mayank,
>
> I do get a message back from the mobile phone, of course after first
> sending a message to it..
> The response of a 'connect-req' from the phone is:
> header:            1100, the response message header is correct, since
> it has the correct MsgID that corresponds to 'connect-resp'
>
> parameter #1:  10010000 ,  meaning that it is the parameterID
> 'ConnectionStatus', with parameter value length 1 and the value is 0 (=
> OK, server can fulfill the requirements)


This is good news. So you get a perfect response from the phone:
0x01 0x01 0x00 0x00 0x01 0x00 0x00 0x01 0x00 0x00 0x00 0x00
This is absolutely perfect connect_resp.

This message is received  from a Nokia 6810 and the MaxMsgSize requested
> in the 'connection-req' was 0x0118. It looks promising so far. I will
> try to get a few more things done now.
> When I request an initial MaxMsgSize of 0xff ff the mobile phone
> responds with
> header: 1200 , so now 2 parameters in the 'connect-resp' message coming up
> parameter #1: 10012000 , connectionStatus  now gives 'Error, Server does
> not support maximum message size'
> parameter #2: 00028000 , the server now suggests MaxMsgSize to be 0x800
>
> And... when I request a small MaxMsgSize (ie 0x0001) the SIM server
> returns the expected 'Error, maximum message size by Client is too small'


Thats OK, but why do you want to try this? 0x118 is good enough.

*But tell me one thing: After you receive a connect_resp from the phone, do
you receive a status_ind as well?*
*This is important, because if you do not receive this, the connection is
not really up. See page 22 of the spec.*

In case you decide to work on this subject as well I am interested in a
> bit of team work.


Of course, I will help you as much as I can.

Regards,
Mayank

------=_Part_51109_15446595.1150868896673
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Goetz,</div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 6/21/06, <b class="gmail_sendername">Goetz Issel</b> &lt;<a href="mailto:g.issel@fh-wolfenbuettel.de">g.issel@fh-wolfenbuettel.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Mayank,<br><br>I do get a message back from the mobile phone, of course after first<br>sending a message to it..
<br>The response of a 'connect-req' from the phone is:<br>header:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1100, the response message header is correct, since<br>it has the correct MsgID that corresponds to 'connect-resp'<br><br>parameter #1:&nbsp;&nbsp;10010000 ,&nbsp;&nbsp;meaning that it is the parameterID
<br>'ConnectionStatus', with parameter value length 1 and the value is 0 (=<br>OK, server can fulfill the requirements)</blockquote>
<div>&nbsp;</div>
<div>This is good news. So you get a perfect response from the phone:</div>
<div>0x01 0x01 0x00 0x00 0x01 0x00 0x00 0x01 0x00 0x00 0x00 0x00</div>
<div>This is absolutely perfect connect_resp.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">This message is received&nbsp;&nbsp;from a Nokia 6810 and the MaxMsgSize requested<br>in the 'connection-req' was 0x0118. It looks promising so far. I will
<br>try to get a few more things done now.<br>When I request an initial MaxMsgSize of 0xff ff the mobile phone<br>responds with<br>header: 1200 , so now 2 parameters in the 'connect-resp' message coming up<br>parameter #1: 10012000 , connectionStatus&nbsp;&nbsp;now gives 'Error, Server does
<br>not support maximum message size'<br>parameter #2: 00028000 , the server now suggests MaxMsgSize to be 0x800<br><br>And... when I request a small MaxMsgSize (ie 0x0001) the SIM server<br>returns the expected 'Error, maximum message size by Client is too small'
</blockquote>
<div>&nbsp;</div>
<div>Thats OK, but why do you want to try this? 0x118 is good enough.</div>
<div>&nbsp;</div>
<div><strong>But tell me one thing: After you receive a connect_resp from the phone, do you receive a status_ind as well?</strong></div>
<div><strong>This is important, because if you do not receive this, the connection is not really up. See page 22 of the spec.</strong></div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">In case you decide to work on this subject as well I am interested in a<br>bit of team work.</blockquote>
<div>&nbsp;</div>
<div>Of course, I will help you as much as I can.</div><br>Regards,</div>
<div>Mayank</div>

------=_Part_51109_15446595.1150868896673--


--===============1701323698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1701323698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1701323698==--
