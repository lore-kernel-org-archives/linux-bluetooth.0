Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1418129488-12353-1-git-send-email-gowtham.ab@samsung.com>
 <1418129488-12353-2-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZLox+KR_PeB8LiW5WDvSCNwU6XG1vPFQqwM4pXQFtRe2Q@mail.gmail.com>
 <000a01d01454$5d1092c0$1731b840$@samsung.com>
 <CABBYNZKtzWvL-akhUeFknJJBy=CatD90G8VFRg0BE4MdS3Vp+Q@mail.gmail.com>
In-reply-to: <CABBYNZKtzWvL-akhUeFknJJBy=CatD90G8VFRg0BE4MdS3Vp+Q@mail.gmail.com>
Subject: RE: [PATCH ] android/socket: Add MAP supported features bits
Date: Wed, 10 Dec 2014 14:17:21 +0530
Message-id: <000b01d01455$ef4449b0$cdccdd10$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Wednesday, December 10, 2014 2:13 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> cpgs@samsung.com
> Subject: Re: [PATCH ] android/socket: Add MAP supported features bits
> 
> Hi Gowtham,
> 
> On Wed, Dec 10, 2014 at 10:36 AM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Hi Luiz,
> >
> >> -----Original Message-----
> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> >> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> >> Sent: Wednesday, December 10, 2014 12:58 PM
> >> To: Gowtham Anandha Babu
> >> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> >> cpgs@samsung.com
> >> Subject: Re: [PATCH ] android/socket: Add MAP supported features bits
> >>
> >> Hi Gowtham,
> >>
> >> On Tue, Dec 9, 2014 at 2:51 PM, Gowtham Anandha Babu
> >> <gowtham.ab@samsung.com> wrote:
> >> > Add MAP supported features in sdp record.
> >> > ---
> >> >  android/socket.c | 5 +++++
> >> >  1 file changed, 5 insertions(+)
> >> >
> >> > diff --git a/android/socket.c b/android/socket.c index
> >> > f2cfd07..d89c8c2 100644
> >> > --- a/android/socket.c
> >> > +++ b/android/socket.c
> >> > @@ -58,6 +58,7 @@
> >> >  /* Hardcoded MAP stuff needed for MAS SMS Instance.*/
> >> >  #define DEFAULT_MAS_INSTANCE   0x00
> >> >
> >> > +#define DEFAULT_MAP_SUPPORTED_FEATURES 0x0000001f
> >> >  #define DEFAULT_PBAP_SUPPORTED_FEATURES 0x00000003
> >> >
> >> >  #define MAP_MSG_TYPE_SMS_GSM   0x02
> >> > @@ -321,6 +322,7 @@ static sdp_record_t *create_mas_record(uint8_t
> >> chan, const char *svc_name)
> >> >         sdp_profile_desc_t profile[1];
> >> >         uint8_t minst = DEFAULT_MAS_INSTANCE;
> >> >         uint8_t mtype = DEFAULT_MAS_MSG_TYPE;
> >> > +       uint8_t supft = DEFAULT_MAP_SUPPORTED_FEATURES;
> >> >         sdp_record_t *record;
> >> >         uuid_t uuid;
> >> >
> >> > @@ -339,6 +341,9 @@ static sdp_record_t *create_mas_record(uint8_t
> >> chan, const char *svc_name)
> >> >         sdp_attr_add_new(record,
> SDP_ATTR_SUPPORTED_MESSAGE_TYPES,
> >> SDP_UINT8,
> >> >
> >> > &mtype);
> >> >
> >> > +       sdp_attr_add_new(record,
> SDP_ATTR_MAP_SUPPORTED_FEATURES,
> >> SDP_UINT32,
> >> > +
> >> > + &supft);
> >> > +
> >> >         sdp_list_free(seq, NULL);
> >> >
> >> >         return record;
> >> > --
> >> > 1.9.1
> >>
> >> I recall supported features being introduced in 1.2, in that case it
> >> is probably not required to add it to the record since Android only support
> 1.1.
> >>
> >
> > Yes, this one is 1.2 feature. Then, I have to wait till 1.2 implementation.
> > Btw, Right now in android,
> > Server (PBAP-PSE and MAP-MAS) records are added to SDP.
> > What happened to client(PBAP-PCE and MAP-MNS) records?
> > Will it be added only after implementing them?
> 
> They don't seem to be supported by Android HAL, so we have to wait Google
> enable them in the upper layer.
> 
> 

Okay. Thanks for you information. 

> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html


Regards,
Gowtham Anandha Babu

