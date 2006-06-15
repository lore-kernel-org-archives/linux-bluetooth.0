Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <85cea3460606142049y81d6573q476aa9e599e4372d@mail.gmail.com>
Date: Wed, 14 Jun 2006 23:49:21 -0400
From: "Sweta Vasudevan" <sweta.vasudevan@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <448C81FC.50509@xmission.com>
MIME-Version: 1.0
References: <85cea3460606111303r218e088ek21d50709fce3c6df@mail.gmail.com>
	<448C81FC.50509@xmission.com>
Subject: Re: [Bluez-devel] btsco and connection problems
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0731022221=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0731022221==
Content-Type: multipart/alternative;
	boundary="----=_Part_48281_27259459.1150343361421"

------=_Part_48281_27259459.1150343361421
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Brad

Yes, the headset is in the pairing mode. I'm not sure if my hcid.conf file
is right:

# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
#

# HCId options
options {
      # Automatically initialize new devices
      autoinit yes;

      # Security Manager mode
      #   none - Security manager disabled
      #   auto - Use local PIN for incoming connections
      #   user - Always ask user for a PIN
      #
      security user;

      # Pairing mode
      #   none  - Pairing disabled
      #   multi - Allow pairing with already paired devices
      #   once  - Pair once and deny successive attempts
      pairing multi;

      # PIN helper
      #pin_helper /usr/bin/bluepin;

      # D-Bus PIN helper
      dbus_pin_helper;
}

# Default settings for HCI devices
device {
      # Local device name
      #   %d - device id
      #   %h - host name
      name "%h-%d";

      # Local device class
      class 0x120104;
        #class 0x3e0100;

      # Default packet type
      #pkt_type DH1,DM1,HV1;

      # Inquiry and Page scan
      iscan enable; pscan enable;

      # Default link mode
      #   none   - no specific policy
      #   accept - always accept incoming connections
      #   master - become master on incoming connections,
      #            deny role switch on outgoing connections
      lm accept;

      # Default link policy
      #   none    - no specific policy
      #   rswitch - allow role switch
      #   hold    - allow hold mode
      #   sniff   - allow sniff mode
      #   park    - allow park mode
      lp rswitch,hold,sniff,park;

      # Authentication and Encryption (Security Mode 3)
      auth disable;
      encrypt disable;
}

Any suggestion will be of great help.

Thanks

sweta

On 6/11/06, Brad Midgley <bmidgley@xmission.com> wrote:
>
> Sweta
>
> > [root@lirr ~]# hcitool info 00:07:A4:26:8D:3F
> > Requesting information ...
> > Can't create connection: Connection timed out
>
> > [root@lirr ~]# btsco 00:07:A4:26:8D:3F
> > Error: Failed to connect to SDP server: Function not implemented
> > Assuming channel 2
> >
> > Can't connect RFCOMM channel: Resource temporarily unavailable
>
> something more fundamental is wrong with your setup if you can't get the
> rfcomm channel connected or an sdp scan. is the headset in pairing mode
> when you are trying this stuff?
>
> make sure /etc/bluetooth/hcid.conf has not been customized, try
> restarting the bluez utils, etc. that's the sort of thing I do, but
> there are probably more systematic ways of narrowing down the problem.
>
> brad
>
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_48281_27259459.1150343361421
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Brad<br><br>Yes, the headset is in the pairing mode. I'm not sure if my hcid.conf file is right:<br><br>

<p class="MsoPlainText"># HCI daemon configuration file.<br>
#<br>
# $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $<br>
#<br>
<br>
# HCId options<br>
options {<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Automatically initialize new
devices<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>autoinit yes;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Security Manager mode<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>none - Security manager disabled<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>auto - Use local PIN for incoming connections<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>user - Always ask user for a PIN<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>security user;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Pairing mode<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>none<span style="">&nbsp; </span>- Pairing disabled<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>multi - Allow pairing with already paired devices<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>once<span style="">&nbsp; </span>- Pair once and deny
successive attempts<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pairing multi;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># PIN helper<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#pin_helper /usr/bin/bluepin;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># D-Bus PIN helper<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>dbus_pin_helper;<br>
}<br>
<br>
# Default settings for HCI devices<br>
device {<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Local device name<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>%d - device id<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>%h - host name<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>name &quot;%h-%d&quot;;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Local device class<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>class 0x120104;<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#class 0x3e0100;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Default packet type<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#pkt_type DH1,DM1,HV1;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Inquiry and Page scan<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>iscan enable; pscan enable;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Default link mode<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>none<span style="">&nbsp;&nbsp; </span>- no specific policy <br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>accept - always accept incoming connections<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>master - become master on incoming connections,<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>deny role switch on outgoing
connections<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>lm accept;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Default link policy<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>none<span style="">&nbsp;&nbsp;&nbsp; </span>- no specific policy<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>rswitch - allow role switch<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>hold<span style="">&nbsp;&nbsp;&nbsp; </span>- allow hold mode<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>sniff<span style="">&nbsp;&nbsp; </span>- allow sniff mode<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>#<span style="">&nbsp;&nbsp;
</span>park<span style="">&nbsp;&nbsp;&nbsp; </span>- allow park mode<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>lp rswitch,hold,sniff,park;<br>
<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span># Authentication and Encryption
(Security Mode 3)<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>auth disable;<br>
<span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>encrypt disable;<br>
}<br>
&nbsp;</p>

Any suggestion will be of great help.<br><br>Thanks<br><br>sweta<br><br><div><span class="gmail_quote">On 6/11/06, <b class="gmail_sendername">Brad Midgley</b> &lt;<a href="mailto:bmidgley@xmission.com">bmidgley@xmission.com
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Sweta<br><br>&gt; [root@lirr ~]# hcitool info 00:07:A4:26:8D:3F<br>&gt; Requesting information ...
<br>&gt; Can't create connection: Connection timed out<br><br>&gt; [root@lirr ~]# btsco 00:07:A4:26:8D:3F<br>&gt; Error: Failed to connect to SDP server: Function not implemented<br>&gt; Assuming channel 2<br>&gt;<br>&gt; Can't connect RFCOMM channel: Resource temporarily unavailable
<br><br>something more fundamental is wrong with your setup if you can't get the<br>rfcomm channel connected or an sdp scan. is the headset in pairing mode<br>when you are trying this stuff?<br><br>make sure /etc/bluetooth/hcid.conf has not been customized, try
<br>restarting the bluez utils, etc. that's the sort of thing I do, but<br>there are probably more systematic ways of narrowing down the problem.<br><br>brad<br><br><br>_______________________________________________<br>Bluez-devel mailing list
<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>
<br></blockquote></div><br>

------=_Part_48281_27259459.1150343361421--


--===============0731022221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0731022221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0731022221==--
