Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112F84B1@SHSMSX104.ccr.corp.intel.com>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
	<CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
	<7926AF24-265F-454D-A502-C3554072752E@holtmann.org>
	<CAHrH25TvLZz+xS11UssE-xKx09UHX9w--Y7YoLdaOBx3LGHxaQ@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F7F7A@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25QHuLFhVcYFMnHfGH4g5SHRyW65-V6gZ5SyPYWGsELmMw@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F84B1@SHSMSX104.ccr.corp.intel.com>
Date: Fri, 5 Sep 2014 07:51:50 -0700
Message-ID: <CAHrH25Ti3PRT41xj7vR-jBJ1z4FoLc9Pz3+PaTptoFa0AgB_AA@mail.gmail.com>
Subject: Re: [PATCH] gatt api V2
From: Arman Uguray <armansito@chromium.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chao Jie,


> In the old stack, doing encode/decode PDU split with sending att protocol command to remote device.
> However, in the new stack , bt_att_send do more things than old did including encode pdu with opcode.
> Because Att pdu signed process include whole data pdu, so in my mind, if we keep consistent style in code,
> we have to do sign att pdu in bt_att_send function. We have to expand bt_att struct to store CSRK and
> so on stuff. So that's the only implementation make sense for signed write command.

That's right, bt_att needs to extended to obtain and store the CSRK
somehow. The signing should happen during bt_att_send as you said
(probably in encode_pdu).


> BTW, compared with signing the outgoing, verifying incoming ATT PDUs would be more complex. I am not
> Sure which file to implement it.

That would be in the incoming PDU handling inside bt_att. The
can_read_data function obtains an incoming PDU and routes it to the
appropriate handler. I think that would be the right place to do it.


Cheers,
Arman
