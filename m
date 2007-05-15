Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 15 May 2007 18:54:34 +0800
Message-ID: <36BC62FC45C4E949B13C20DEFA8617D5054D2C7C@zmy16exm62.ds.mot.com>
References: <AF7E222731C6614DAB496712B5768F2401EB332C@ct11exm65.ds.mot.com>  
From: "GAO LIANG-TAO-W20048" <l.t.gao@motorola.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Report a bug against "l2cap_conf_output()"
	in"net/bluetooth/l2cap.c"
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

Sorry for getting back late.

I think you omitted the local outgoing MTU. The original code will
enlarge the outgoing MTU value, but the Bluetooth SPEC expects a minimum
of the MTU in the config request and the local outgoing MTU.

For example, if Device B starts an L2CAP service with incoming MTU 512,
and an L2CAP client on Device A claiming an outgoing MTU 53 tries to
connect to the service; the service on B sends configuration request to
the BlueZ stack on A with MTU 512, then A shall sends back a positive
response to B with the MTU 53 (not 512 as BlueZ actually does). In fact
this example is from a JSR82 MTU test case.

Here's the whole paragraph in page 1038 (of the total 1230) in Bluetooth
SPEC Core_v2.0_EDR.pdf:
"If the remote device sends a positive configuration response it shall
include the actual MTU to be used on this channel for traffic flowing
into the local device. This is the minimum of the MTU in the
configuration request and the outgoing MTU capability of the device
sending the configuration response. The new agreed value (the default
value in a future re-configuration) is the value specified in the
request."

My understanding is that the MTU can be increased in no cases. Please
let me know your consideration of this paragraph.

Thanks
Gao Liangtao


-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org] 
Sent: Friday, May 04, 2007 1:56 AM
To: BlueZ development
Cc: Singer Catherine-CSINGER1; Jin Hong-Lei-W19971; Saeed Faisal-EFS015
Subject: Re: [Bluez-devel] Report a bug against "l2cap_conf_output()"
in"net/bluetooth/l2cap.c"

Hi,

> 
> I want to report a bug against "l2cap_conf_output()" in BlueZ kernel 
> code "net/bluetooth/l2cap.c":
> 
>     if (pi->conf_mtu < pi->omtu) {
> 
>        l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);
> 
>        result = L2CAP_CONF_UNACCEPT;
> 
>     } else {
> 
>        pi->omtu = pi->conf_mtu;
> 
>     }
> 
> I think it's wrong to enlarge the outgoing MTU value (by calling 
> "pi->omtu = pi->conf_mtu") when device B gets the MTU in device A's 
> configuration request. In fact, Page 1006/1200 of Bluetooth SPEC v1.2 
> or Page 1038/1230 of Bluetooth SPEC v2.0 EDR both require a minimum of

> the  "If the remote device sends a positive configuration response it 
> shall include the actual MTU to be used on this channel for traffic 
> flowing into the local device. This is the minimum of the MTU in the 
> configuration request and the outgoing MTU capability of the device 
> sending the configuration response." Here I consider the original 
> "pi->omtu" as the "outgoing MTU capability".

I need more details from you, because I don't see the issue here. The
MTUs (output + input) for L2CAP are negotiated in both directions.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
