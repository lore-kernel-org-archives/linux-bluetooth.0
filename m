Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5000105b05010705172040f6c3@mail.gmail.com>
From: Amit Kumar Goel <amitgoel25aug@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SDP & RFCOMM SYNC
In-Reply-To: <1105102531.4299.97.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <5000105b0501070138cd4b4a8@mail.gmail.com>
	 <1105102531.4299.97.camel@pegasus>
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
Date: Fri, 7 Jan 2005 18:47:36 +0530

Hi Marcel,

can u explain how it is possible? 

Because only one  l2cap connection is possible over a ACL connection
(between 2 devices).

According to SDP specification, SDP seesion first issue a SDP connect,
send SDP query, wait for response and then send SDP disconnect.
 
 if we start a SDP session, What will happen with the l2cap
connection, over which 1( or more ) rfcomm session is running?

Should l2cap implementation provide a support for this or SDP should
check for that?

if so how to implement this at the l2cap level? 

Regards 
Amit

On Fri, 07 Jan 2005 13:55:31 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Amit,
> 
> > I am working over SDP layer & i want to suport multiple profile over rfcomm.
> >
> > I want to know how I can implement the following situation.
> >
> > Already there is one rfcomm (ACL) connection with the remote device by
> > a profile .Other profile wants to make sdp session with the same
> > device.How can we send query request over the l2cap chanel?
> >
> > If so, wat will happen after if sdp sends a disconnect request after query?
> 
> this simply works. The kernel is able to handle multiple L2CAP and
> RFCOMM connections without any problems.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
