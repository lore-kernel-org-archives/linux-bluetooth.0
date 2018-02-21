Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2071439.3ZS44CKUQD@ix>
References: <20180220151358.20781-1-szymon.janc@codecoup.pl>
 <CABBYNZ+gAGOHFyJ+gCDiTf_cJMF_+g5cyx2JtQ5S4nh_eUGGzQ@mail.gmail.com> <2071439.3ZS44CKUQD@ix>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Feb 2018 11:25:36 +0200
Message-ID: <CABBYNZ+M7nji36uR51Nvyw2ikN_ixc9C8sY5ZzM7b+tHn1y=YQ@mail.gmail.com>
Subject: Re: [PATCH] advertising: Fix setting discoverable flag only for peripheral
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Feb 21, 2018 at 9:59 AM, Szymon Janc <szymon.janc@codecoup.pl> wrot=
e:
> Hi Luiz,
>
> On Tuesday, 20 February 2018 17:21:54 CET Luiz Augusto von Dentz wrote:
>> Hi Szymon,
>>
>> On Tue, Feb 20, 2018 at 5:13 PM, Szymon Janc <szymon.janc@codecoup.pl>
> wrote:
>> > General Discoverable mode can also be set for non-connectable
>> > advertising. This was affecting GAP/DISC/GENM/BV-03-C qualification
>> > testcase.
>> > ---
>> >
>> >  src/advertising.c | 7 +++----
>> >  1 file changed, 3 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/src/advertising.c b/src/advertising.c
>> > index 38d2a2d1f..6e227d4d1 100644
>> > --- a/src/advertising.c
>> > +++ b/src/advertising.c
>> > @@ -622,12 +622,11 @@ static int refresh_adv(struct btd_adv_client
>> > *client, mgmt_request_func_t func)>
>> >         DBG("Refreshing advertisement: %s", client->path);
>> >
>> > -       if (client->type =3D=3D AD_TYPE_PERIPHERAL) {
>> > +       if (client->type =3D=3D AD_TYPE_PERIPHERAL)
>> >
>> >                 flags =3D MGMT_ADV_FLAG_CONNECTABLE;
>> >
>> > -               if
>> > (btd_adapter_get_discoverable(client->manager->adapter))
>> > -                       flags |=3D MGMT_ADV_FLAG_DISCOV;
>> > -       }
>> > +       if (btd_adapter_get_discoverable(client->manager->adapter))
>> > +               flags |=3D MGMT_ADV_FLAG_DISCOV;
>>
>> iirc there were something saying that non-connectable advertisement
>> should not set these flags, if I recall this right this was why
>> beacons used to not show on the discovery or something like that.
>
> As mentioned in commit there is qualification test which tests it.
>
> GAP/DISC/GENM/BV-03-C
> [General Discoverable Mode Non-Connectable Mode - LE Only]
>
> That said, this patch isn't valid since in bluetoothd discoverable requir=
es
> connectable so currently we are not able to configure non-connectable
> advertising instance when discoverable.
>
> I think we should extend Add Advertising mgmt command with flag that woul=
d
> allow to force non-connectable advertising regardless of global connectab=
le
> flag.
>
> Thoughts?

I guess I was assuming that discoverable would always be connectable
aka. Peripheral Mode, since  Broadcast Mode shall not set these flags:

'A device in the broadcast mode shall not set the =E2=80=98LE General Disco=
verable Mode=E2=80=99
flag or the =E2=80=98LE Limited Discoverable Mode=E2=80=99 flag in the Flag=
s AD Type as defined
in [Core Specification Supplement], Part A, Section 1.3.'

Perhaps this test is not really for broadcast mode, but our D-Bus is,
so I wonder how we can accommodate this, or perhaps this would go
under Peripheral Mode? I really thought the distinction of broadcast
vs peripheral would be the use of non-connectable vs connectable
advertisements but that doesn't seem to be true for the test above.

--=20
Luiz Augusto von Dentz
