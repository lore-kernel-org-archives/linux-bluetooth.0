Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000401c6bfb5$be812bc0$9d0cc70a@dlh.st.com>
References: <000401c6bfb5$be812bc0$9d0cc70a@dlh.st.com>
Date: Mon, 14 Aug 2006 22:26:04 +0200
Message-Id: <1155587165.4075.10.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
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

Hi Mayank,

> I propose the following changes (in addition to those suggested by Ulisses
> earlier) for implementing Controller to Host Flow Control:
> 
> (i) Update hci.h to include commands like host number of completed packets
> cmd and set controller to host flow control cmd.

we need them for the kernel, bluez-libs and bluez-hcidump. Go ahead and
send in patches for it.

> (ii) Update hcid.h file to include an additional member to the enum:
> enum {
> 	HCID_SET_NAME,
> 	HCID_SET_CLASS,
> 	HCID_SET_VOICE,
> 	HCID_SET_INQMODE,
> 	HCID_SET_PAGETO,
> 	HCID_SET_DISCOVTO,
> 	HCID_SET_PTYPE,
> 	HCID_SET_LM,
> 	HCID_SET_LP,
> +	HCID_SET_C_TO_HOST_FC,
> };
> 
> And update the structure device_opts:
> struct device_opts {
> 	unsigned long flags;
> 	char    *name;
> 	uint32_t class;
> 	uint16_t voice;
> 	uint8_t  inqmode;
> 	uint16_t pageto;
> 	uint16_t pkt_type;
> 	uint16_t link_mode;
> 	uint16_t link_policy;
> 	uint16_t scan;
> 	int      discovto;
> +	int		c_to_host_fc;
> };
> 
> Of course, this means that the hcid.conf (and parser.y) will contain another
> entry to enable/disable flow control.

No additional config option at the moment. It is not needed right now.
If we really want it, we can do it later.

> > > (i) For enabling FC from HC to Host, the host first of all 
> > sends Host Buffer
> > > Size Command providing the number of ACL and SCO buffers and their
> > > respective sizes.
> > > (ii) The host then issues Set Host Controller To Host Flow 
> > Control Command.
> 
> (iii) The host buffer size command and set controller to host flow
> controller command can be sent from configure_device() of hcid/main.c

No. This must be done in the kernel. It is not the job of hcid.

> > > (iii) Host will send a Host Number of Completed Packets 
> > Command to the
> > > controller.
> 
> But, I could not figure out from where should we send the Host Number of
> completed packets command. Do you have any suggestions. I mean, can you give
> me an idea where can we get to know the receipt of ACL Data at user level?

This must be done in the kernel. It is like sniff mode support. Only the
kernel knows all facts.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
