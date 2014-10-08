Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000f01cfe21b$7cdac460$76904d20$@samsung.com>
References: <000f01cfe21b$7cdac460$76904d20$@samsung.com>
Date: Wed, 8 Oct 2014 13:47:24 +0300
Message-ID: <CABBYNZ+E4vG-y1+oKMgBiydd3KMDD51Hht19ACcuQKVtHynHxQ@mail.gmail.com>
Subject: Re: Query regarding the PTS MAP 1.2 push message test case execution
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 7, 2014 at 1:42 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi,
>
> I am currently validating all the test cases of PTS 5.3 for MAP 1.2.
> How to push the message bluez map-client to MSE(server)?
> The approach which I followed is described below:
>
> On MCE(Bluez - map-client):
> 1) Run bluetoothd
> 2) Run obexd
> 3) ./map-client -d <REMOTE_BT_ADDR>  -c telecom/msg/outbox/ -p PUSH_MSG
>
> On MSE(PTS tool)
> 1) Running the test-case: TC_MCE_MMU_BV_01_I
> 2) After running the test-case. I am getting the User Action Required
> (Please find this in attached image).
>
> The PUSH_MSG will be the filename of the message which we are pushing to
> MSE(server).
> So, I tried pushing the attached file with the same command as shown above
> by replacing PUSH_MSG with filename of the attached.
> But I am getting "org.bluez.obex.Error.Failed: Unable to open file".
>
> How to push the message? Am I missing something?

First you need to check if obexd has permission to open the file, also
you can try obexctl instead using send command should have the same
result as map-client but it is a bit more up to date in terms of
features.


-- 
Luiz Augusto von Dentz
