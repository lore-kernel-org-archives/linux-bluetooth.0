Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Question concerning l2cap_parse_conf_req()
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1137698545.22814.11.camel@localhost.localdomain>
References: <1137698545.22814.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Message-Id: <1138354614.7949.11.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Fri, 27 Jan 2006 10:36:54 +0100

Am Donnerstag, den 19.01.2006, 20:22 +0100 schrieb Martin R=C3=B6hricht:
> I'm partly rewriting the l2cap_parse_conf_req() function but there's
> something that I do not quite understand and perhaps one from this list
> has an idea.
> In this mentioned function we use a while() loop that checks the length
> of the remaining configuration request; inside the loop the length field
> is continuously decreased. Now my question comes into play: Why do we
> need this while loop? As we are already in a configuration request (code
> 0x04), I can't see anything in the current specification that we might
> have more than one =C2=BBConfiguration Options=C2=AB within one Configura=
tion
> Request packet. The Continuation flag (C) has a different meaning:
> 	=C2=BBWhen all configuration options cannot fit into a Configuration=20
> 	 Request with length that does not exceed the receiver's=20
> 	 MTUsig, the options shall be passed in multiple configuration=20
> 	 command packets.=C2=AB (page 48 of BLUETOOTH SPECIFICATION Version=20
> 	 2.0 + EDR [vol 4])
> I see that we can have multiple commands in one L2CAP packet (see page
> 41), but if we parse only one Configuration Request that shouldn't
> apply.

I think I changed my point of view. In figure 4.6 (Configuration Request
Packet) on page 48 the specification treats =C2=BBConfiguration
options=C2=AB (plural form) and later they say:
	=C2=BBEach configuration request shall contain an integral number of=20
	 options. [...] The result of the configuration transaction is=20
	 the union of all the result values.=C2=AB
So I think it's still not 100% clear from the specification but I would
assume that a configuration request packet may contain more than only on
configuration option, e.g. MTU + QoS + RFC.=20
But what happens if the configuration request contains one of these
options more than once? Let's say the remote peer sends MTU + MTU.
Should we use the last value? What happens if the remote peer sends a
config request with one option that we do not know of, e.g. MTU + RFC --
shall we process the MTU or reject the whole request? In best case, the
remote peer took it's information from an information request, but
that's not mandatory.=20
I think the specification is not precise enough in some points.

Martin



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
