Return-Path: <cyrus@holtmann.org>
From: Hirenkumar Tandel <hirent@marvell.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, Bing Zhao <bzhao@marvell.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>, Rahul Tank <rahult@marvell.com>,
        Quinton Yuan <qyuan@marvell.com>
Date: Sun, 30 Mar 2014 21:34:28 -0700
Subject: RE: [PATCH] Bluetooth: Fix to auto accept pairing request for no
 MITM case
Message-ID: <CBACCFA0AEB13A41977475BCF3E896FC3E9D2AE11D@SC-VEXCH2.marvell.com>
References: <1391626900-11168-1-git-send-email-bzhao@marvell.com>
 <20140329072359.GA31453@t440s.P-661HNU-F1>
In-Reply-To: <20140329072359.GA31453@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com]=20
Sent: Saturday, March 29, 2014 12:54 PM
To: Bing Zhao
Cc: linux-bluetooth@vger.kernel.org; Marcel Holtmann; Gustavo Padovan; Hire=
nkumar Tandel; Rahul Tank; Quinton Yuan
Subject: Re: [PATCH] Bluetooth: Fix to auto accept pairing request for no M=
ITM case

Hi,

On Wed, Feb 05, 2014, Bing Zhao wrote:
> With existing implementation, during incoming SSP if no side requires=20
> MITM protection, user confirm request event is forwarded to user space=20
> for further user confirmation without checking io capability of local=20
> host. But in case if there is no agent registered with bluez user=20
> space daemon which means device has NoInputNoOutput capability at that=20
> moment, it rejects the request.
>=20
> This patch will check for io capability of local host before=20
> forwarding request to user space. If local host has NoInputNoOutput=20
> capability, there is no point in forwarding request to user space.=20
> Hence local host kernel goes ahead with auto accept, by sending User=20
> Confirmation Request Reply command.
>=20
> Signed-off-by: Hiren Tandel <hirent@marvell.com>
> Signed-off-by: Rahul Tank <rahult@marvell.com>
> Signed-off-by: Quinton Yuan <qyuan@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
>  net/bluetooth/hci_event.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c=20
> index d2c6878..b61f0c6 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3239,8 +3239,13 @@ static void hci_user_confirm_request_evt(struct=20
> hci_dev *hdev,
> =20
>  		/* If we're not the initiators request authorization to
>  		 * proceed from user space (mgmt_user_confirm with
> -		 * confirm_hint set to 1). */
> -		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
> +		 * confirm_hint set to 1).
> +		 * But if local host has NoInputNoOutput capability,
> +		 * then no use of passing request to user space,
> +		 * so go ahead with auto accept.
> +		 */
> +		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
> +		    conn->io_capability !=3D HCI_IO_NO_INPUT_OUTPUT) {
>  			BT_DBG("Confirming auto-accept as acceptor");
>  			confirm_hint =3D 1;
>  			goto confirm;

So basically this changes the policy from rejecting pairings when an agent =
is not registered to accepting them in case it's a just-works pairing? I'm =
not convinced we want to do such a policy change that relaxes security in t=
his regard.

Do you have an actual product use case for this? What's the background and =
reasoning behind it?

[Hiren]A use case is for chrome book, for user not logged in case, Bluetoot=
h is working at this time, but default-agent is not registered, however use=
r will expect  Bluetooth to work for certain simple devices like mouse.

Johan

Thanks,
Hiren
