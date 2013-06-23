Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: pull request: bluetooth 2013-06-23
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130623075808.GA1495@x220.P-661HNU-F1>
Date: Sun, 23 Jun 2013 09:01:21 -0400
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <2B261261-BC0D-45B0-95D1-47E8D4F34772@holtmann.org>
References: <20130623021351.GA2327@joana> <20130623075808.GA1495@x220.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>> A important fix to 3.10, this patch fixes an issues that was preventing the 
>> l2cap info response command to be handled properly. Please pull. Thanks!
> 
> I'd like to add here (since it's not obvious) that this is not just
> about failing to parse the L2CAP info response. Once the code gives up
> parsing this PDU it also gives up essential parts of the L2CAP
> connection creation process, i.e. without this patch the stack will fail
> to establish connections properly. So it'd be very good if we can get
> this into 3.10 (as well as the stable trees where the patch that
> introduced this bug is already on its way).

I moved this to linux-bluetooth only now to not derail the process of getting this fixed upstream, but why was this information not part of the commit message.

Commit messages are there to explain the impact in plain English. I really mean plain English and not assuming everybody understands Bluetooth and can read HCI traces.

Especially commit message for patches after the merge window closed should be verbose. In addition the cover letter to John needs to explain why this is important and justifies inclusion after -rc7. Why is this a regression that needs to be fixed right away.

If I would be in John's shoes, I would not classify this as an important enough fix to go in after -rc7. The cover letter does not tell him the impact and the commit message does not tell him anything either. Neither John, Dave or Linux know enough about L2CAP to come to the conclusion that this a regression and will break Bluetooth connections.

Regards

Marcel

