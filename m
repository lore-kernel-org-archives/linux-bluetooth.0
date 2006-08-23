Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170608230606i7b03a68ele44294096746475b@mail.gmail.com>
Date: Wed, 23 Aug 2006 10:06:07 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001b01c6c677$b6a851d0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
References: <d23110170608221347p37bc87a5mbdd1271eaf7631c3@mail.gmail.com>
	<001b01c6c677$b6a851d0$9d0cc70a@dlh.st.com>
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

On 8/23/06, Mayank BATRA <mayank.batra@st.com> wrote:
>         case OCF_HOST_BUFFER_SIZE:
>                 status = *((__u8 *) skb->data);
> -               if (status) {
> +               if (!status) {
> +                       struct hci_cp_set_host_flow_ctl cp;
> +
> +                       if (!(cp.host_flow_ctl = hdev->host_flow_ctl))
> +                               break;
> +
> +                       hci_send_cmd(hdev, OGF_HOST_CTL,
> +                                    OCF_SET_HOST_FLOW_CTL, sizeof(cp),
> &cp);
> +               } else {
>                         BT_DBG("%s OCF_BUFFER_SIZE failed %d", hdev->name,
> status);
>                         hci_req_complete(hdev, status);
>                 }
>
> If status = 0 it means that the command was success. But in the patch that
> you sent, it's the other way round. Is it a mistake?

I think it's right, take a look at the patch again (there's a !status there).

Regards,

-- Ulisses

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
