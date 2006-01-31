Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Question concerning l2cap_parse_conf_req()
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1138354614.7949.11.camel@localhost.localdomain>
References: <1137698545.22814.11.camel@localhost.localdomain>
	 <1138354614.7949.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Message-Id: <1138702410.12063.18.camel@localhost.localdomain>
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
Date: Tue, 31 Jan 2006 11:13:30 +0100

Am Freitag, den 27.01.2006, 10:36 +0100 schrieb Martin R=C3=B6hricht:
> Am Donnerstag, den 19.01.2006, 20:22 +0100 schrieb Martin R=C3=B6hricht:
> > I can't see anything in the current specification that we might
> > have more than one =C2=BBConfiguration Options=C2=AB within one Configu=
ration
> > Request packet.=20
> I think I changed my point of view. In figure 4.6 (Configuration Request
> Packet) on page 48 the specification treats =C2=BBConfiguration
> options=C2=AB (plural form) and later they say:
> 	=C2=BBEach configuration request shall contain an integral number of=20
> 	 options. [...] The result of the configuration transaction is=20
> 	 the union of all the result values.=C2=AB
> So I think it's still not 100% clear from the specification but I would
> assume that a configuration request packet may contain more than only on
> configuration option, e.g. MTU + QoS + RFC.=20

The specification distinguishes between =C2=BBconfiguration options=C2=AB a=
nd
=C2=BBconfiguration parameter options=C2=AB. The latter consists of type, l=
ength
and (arbitrarily long) data as parameters. So the sentence "Each
configuration request shall contain an integral number of options"
refers to the options and not to the parameters (e.g. RFC has 6
parameters). Therefore we can have a configuration request packet that
carries MTU, FlushTo, QoS and RFC -- and in case this packet exceeds the
MTU size, it needs to be split into requests that contain full options
and it needs to set the C flag.

> But what happens if the configuration request contains one of these
> options more than once? Let's say the remote peer sends MTU + MTU.
> Should we use the last value? What happens if the remote peer sends a
> config request with one option that we do not know of, e.g. MTU + RFC --
> shall we process the MTU or reject the whole request? In best case, the
> remote peer took it's information from an information request, but
> that's not mandatory.=20

If the remote peer sends configuration options that we do not
understand, e.g. currently Retransmission and Flow Control (hopefully
not longer than necessary ;-)) we must respond with an overall error
code of 0x0003 -> Failure, unknown options. We do not process the MTU
request in this case until we can respond with an successful result code
to an incoming configuration request. Further more we have to include
those options not understood by us into the response (unless they are
hints). See p. 51.
In case the remote peer sends multiple options of one kind I couldn't
yet figure out a clear statement of the specification (perhaps it is
assumed to be implementation specific) of what we have to do, but in
case we can't find a clear advise, I'd suggest to take either the first
or the last one.

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
