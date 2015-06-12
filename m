Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1434021563-5761-1-git-send-email-bharat.panda@samsung.com>
 <CABBYNZKC2Dmm0stPTMTFw_a8s7egcfj0Cq9HKjz4rCNhQVNebw@mail.gmail.com>
 <004401d0a505$4238e9b0$c6aabd10$@samsung.com>
 <CABBYNZKYxxdvGQn80EkPw3LSMGsKJjUy1T9g5unL49O3VhQRwA@mail.gmail.com>
In-reply-to: <CABBYNZKYxxdvGQn80EkPw3LSMGsKJjUy1T9g5unL49O3VhQRwA@mail.gmail.com>
Subject: RE: [PATCH ] tools/l2test: Add support for l2cap config request
Date: Fri, 12 Jun 2015 19:16:04 +0530
Message-id: <004601d0a516$30aad530$92007f90$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Friday, June 12, 2015 5:49 PM
> To: Bharat Bhusan Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH ] tools/l2test: Add support for l2cap config request
> 
> Hi Bharat,
> 
> On Fri, Jun 12, 2015 at 2:44 PM, Bharat Bhusan Panda
> <bharat.panda@samsung.com> wrote:
> > Hi Luiz,
> >
> >> -----Original Message-----
> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> >> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> >> Sent: Friday, June 12, 2015 4:16 PM
> >> To: Bharat Panda
> >> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> >> Subject: Re: [PATCH ] tools/l2test: Add support for l2cap config
> >> request
> >>
> >> Hi Bharat,
> >>
> >> On Thu, Jun 11, 2015 at 2:19 PM, Bharat Panda
> >> <bharat.panda@samsung.com> wrote:
> >> > This allows to send l2cap configuration request by providing '-o'
> >> > option to l2test along with '-f' option to add destination CID.
> >> >
> >> > e.g.,
> >> >
> >> > l2test command format:
> >> > l2test -o -X <mode> -f <destination CID> -P <psm> <bd_addr>
> >>
> >> But the kernel should handle this for us, why do you need to do it
> manually?
> > I am not sure, whether kernel is handling it, as in my setup it fails for below
> PTS test cases, with error "MTC: The IUT does not sent subsequent
> ConfigReq or DisconnectReq after Rtx Timeout. Wait for timeout...."
> >
> > L2CAP Basic Mode
> > TP/COS/CED/BV-08-C
> > TP/COS/CFD/BV-02-C
> >
> > L2CAP ERTM mode
> > TP/CMC/BV-01-C
> > TP/CMC/BV-02-C
> > TP/CMC/BV-03-C
> > TP/CMC/BV-07-C
> > TP/CMC/BV-14-C
> >
> > Anything needs to be configured in kernel, to handle it?
> 
> Have you checked the android documentation?
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/pts-l2cap.txt
Thanks, I have gone through the pts report of l2cap, and it passes for all the test cases I mentioned above, but by skipping intermediate steps for configuration negotiation.

Please correct me if I am wrong at any point. As in the PTS log I mentioned, PTS expects subsequent ConfigReq for negotiation (optional)or a DisconnectReq. As IUT dint send subsequent ConfigReq in desired time, after timeout it waits for more 65 secs to receive the ConfigReq. Still after, when it doesn't get a config request from IUT, it PASSes the TC assuming no further configuration negotiation. 
So this patch will allow to test if you have further negotiation on configuration. As per the PTS test case description it says so but it is an optional feature. If it is so necessary test case, then we can add this to tree.

Test case : TC_COS_CED_BV_08_C started
	- MTC: PTS successfully established an ACL connection.
	- The IUT sent an extended feature L2CAP Information Request.
	- The IUT sent an L2CAP Information Request.
	- MTC: The IUT correctly responded with correctly formatted L2CAP CONNECT RSP.
	- MTC: The IUT successfully sent a L2CAP_ConfigReq.
	- Tester holding config response for 65 seconds. IUT can optionally send subsequent configReq or disconnectReq during 65 seconds...
	- MTC: The IUT does not sent subsequent ConfigReq or DisconnectReq after Rtx Timeout. Wait for timeout...
	- MTC: Send config request after 65 seconds.
	- MTC: Do not receive ConfigRsp after 5 seconds.
	- CM_EXIT
	- CM_EXIT
	- CM_EXIT
	- MTC: Test case ended
	 -Final Verdict: PASS
TC_COS_CED_BV_08_C finished
> 
> 
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

Best Regards,
Bharat


