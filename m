Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, =?utf-8?B?TWljaGHFgg==?= Narajowski <michal.narajowski@codecoup.pl>
Subject: Re: [PATCH v2 1/6] Bluetooth: Add support for local name in scan rsp
Date: Sun, 18 Sep 2016 20:02:00 +0200
Message-ID: <13282836.rxNiV5Wpcd@ix>
In-Reply-To: <FE85FEDF-CBFA-4365-926B-74DE3F69EA14@holtmann.org>
References: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl> <FE85FEDF-CBFA-4365-926B-74DE3F69EA14@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sunday, 18 September 2016 16:28:11 CEST Marcel Holtmann wrote:
> Hi Szymon,
>=20
> > This patch enables appending local name to scan response data. If
> > currently advertised instance has name flag set it is expired
> > immediately.
> >=20
> > Signed-off-by: Micha=C5=82 Narajowski <michal.narajowski@codecoup.pl>
> > Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> > ---
> > net/bluetooth/hci_request.c | 28 +++++++++++++++++++--------
> > net/bluetooth/mgmt.c        | 46
> > +++++++++++++++++++++++++++++++++++++++++++-- 2 files changed, 64
> > insertions(+), 10 deletions(-)
> >=20
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 9566ff8..0ce6cdd 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -971,14 +971,14 @@ void __hci_req_enable_advertising(struct hci_requ=
est
> > *req)>=20
> > 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
> >=20
> > }
> >=20
> > -static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> > +static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
> > {
> > -	u8 ad_len =3D 0;
> >=20
> > 	size_t name_len;
> >=20
> > +	int max_len;
> >=20
> > +	max_len =3D HCI_MAX_AD_LENGTH - ad_len - 2;
> >=20
> > 	name_len =3D strlen(hdev->dev_name);
> >=20
> > -	if (name_len > 0) {
> > -		size_t max_len =3D HCI_MAX_AD_LENGTH - ad_len - 2;
> > +	if (name_len > 0 && max_len > 0) {
> >=20
> > 		if (name_len > max_len) {
> > 	=09
> > 			name_len =3D max_len;
> >=20
> > @@ -997,22 +997,34 @@ static u8 create_default_scan_rsp_data(struct
> > hci_dev *hdev, u8 *ptr)>=20
> > 	return ad_len;
> >=20
> > }
> >=20
> > +static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> > +{
> > +	return append_local_name(hdev, ptr, 0);
> > +}
> > +
> > static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instan=
ce,
> >=20
> > 					u8 *ptr)
> >=20
> > {
> >=20
> > 	struct adv_info *adv_instance;
> >=20
> > +	u32 instance_flags;
> > +	u8 scan_rsp_len =3D 0;
> >=20
> > 	adv_instance =3D hci_find_adv_instance(hdev, instance);
> > 	if (!adv_instance)
> > =09
> > 		return 0;
> >=20
> > -	/* TODO: Set the appropriate entries based on advertising instance=20
flags
> > -	 * here once flags other than 0 are supported.
> > -	 */
> > +	instance_flags =3D adv_instance->flags;
> > +
> >=20
> > 	memcpy(ptr, adv_instance->scan_rsp_data,
> > =09
> > 	       adv_instance->scan_rsp_len);
> >=20
> > -	return adv_instance->scan_rsp_len;
> > +	scan_rsp_len +=3D adv_instance->scan_rsp_len;
> > +	ptr +=3D adv_instance->scan_rsp_len;
> > +
> > +	if (instance_flags & MGMT_ADV_FLAG_LOCAL_NAME)
> > +		scan_rsp_len =3D append_local_name(hdev, ptr, scan_rsp_len);
> > +
> > +	return scan_rsp_len;
> > }
> >=20
> > void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instanc=
e)
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 74179b9..fa1f1c7 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -3014,6 +3014,35 @@ static int user_passkey_neg_reply(struct sock *s=
k,
> > struct hci_dev *hdev,>=20
> > 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
> >=20
> > }
> >=20
> > +static void adv_expire(struct hci_dev *hdev, u32 flags)
> > +{
> > +	struct adv_info *adv_instance;
> > +	struct hci_request req;
> > +	int err;
> > +
> > +	adv_instance =3D hci_find_adv_instance(hdev, hdev->cur_adv_instance);
> > +	if (!adv_instance)
> > +		return;
> > +
> > +	/* stop if current instance doesn't need to be changed */
> > +	if (!(adv_instance->flags & flags))
> > +		return;
>=20
> are you sure this is correct? Isn't this !(current_flags ^ new_flags) what
> you are looking for.

I want to expire current advertising only if it has specific flag(s) set. E=
g=20
if name is changed, only expire if current advertising has name flag, if=20
apperance is change, only expire if apprearance flag is set etc.

>=20
> Also we should really have mgmt-tester test cases for this. We want to ma=
ke
> sure that this works for active instances and also the default instance 0
> (aka Set Advertising).

Yeap, will send updated mgmt-tester patches next week.

> > +
> > +	cancel_adv_timeout(hdev);
> > +
> > +	adv_instance =3D hci_get_next_instance(hdev, adv_instance->instance);
> > +	if (!adv_instance)
> > +		return;
> > +
> > +	hci_req_init(&req, hdev);
> > +	err =3D __hci_req_schedule_adv_instance(&req, adv_instance->instance,
> > +					      true);
> > +	if (err)
> > +		return;
> > +
> > +	hci_req_run(&req, NULL);
> > +}
> > +
> > static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opco=
de)
> > {
> >=20
> > 	struct mgmt_cp_set_local_name *cp;
> >=20
> > @@ -3029,13 +3058,17 @@ static void set_name_complete(struct hci_dev
> > *hdev, u8 status, u16 opcode)>=20
> > 	cp =3D cmd->param;
> >=20
> > -	if (status)
> > +	if (status) {
> >=20
> > 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
> > 	=09
> > 			        mgmt_status(status));
> >=20
> > -	else
> > +	} else {
> >=20
> > 		mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
> > 	=09
> > 				  cp, sizeof(*cp));
> >=20
> > +		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
> > +			adv_expire(hdev, MGMT_ADV_FLAG_LOCAL_NAME);
> > +	}
> > +
> >=20
> > 	mgmt_pending_remove(cmd);
> >=20
> > unlock:
> > @@ -5887,6 +5920,7 @@ static u32 get_supported_adv_flags(struct hci_dev
> > *hdev)>=20
> > 	flags |=3D MGMT_ADV_FLAG_DISCOV;
> > 	flags |=3D MGMT_ADV_FLAG_LIMITED_DISCOV;
> > 	flags |=3D MGMT_ADV_FLAG_MANAGED_FLAGS;
> >=20
> > +	flags |=3D MGMT_ADV_FLAG_LOCAL_NAME;
> >=20
> > 	if (hdev->adv_tx_power !=3D HCI_TX_POWER_INVALID)
> > =09
> > 		flags |=3D MGMT_ADV_FLAG_TX_POWER;
> >=20
> > @@ -5963,6 +5997,10 @@ static bool tlv_data_is_valid(struct hci_dev *hd=
ev,
> > u32 adv_flags, u8 *data,>=20
> > 			tx_power_managed =3D true;
> > 			max_len -=3D 3;
> > 	=09
> > 		}
> >=20
> > +	} else {
> > +		/* at least 1 byte of name should fit in */
> > +		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
> > +			max_len -=3D 3;
> >=20
> > 	}
> > =09
> > 	if (len > max_len)
> >=20
> > @@ -6295,6 +6333,10 @@ static u8 tlv_data_max_len(u32 adv_flags, bool
> > is_adv_data)>=20
> > 		if (adv_flags & MGMT_ADV_FLAG_TX_POWER)
> > 	=09
> > 			max_len -=3D 3;
> >=20
> > +	} else {
> > +		/* at least 1 byte of name should fit in */
> > +		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
> > +			max_len -=3D 3;
> >=20
> > 	}
>=20
> So I do not get the math here. Either the short name will fit or the long
> name. Especially the Get Advertising Size Information command should retu=
rn
> the accurate leftover size. I mean if the name utilizes all the space, th=
en
> this should return 0.
>=20
> Also the short name is maximal 11 + 2 octets. Meaning it will always fit
> together with appearance no matter what. So if long name is too large, th=
en
> we pick the short name and return the leftover space.

That was my thinking as well initially but...shortened name is never used f=
or=20
HCI (only copied to mgmt events so I assumed this is legacy cruft).
What is done is that name is shortened if it doesn't fit (which make sense=
=20
since shortened name should always be full name substring). But seems like =
max=20
shortened name length is not respected eg for EIR shortened name is used if=
=20
name length is >48 chars....

I can work on that but I think this can be seprate patchset that would clea=
n=20
all of above issues.

>=20
> Regards
>=20
> Marcel


=2D-=20
pozdrawiam
Szymon Janc
