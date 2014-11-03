Return-Path: <cyrus@holtmann.org>
Message-id: <545710F4.2090208@samsung.com>
Date: Mon, 03 Nov 2014 14:21:56 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2] Bluetooth : Fix hci_sync miss wakeup interrupt
References: <1414732986-20487-1-git-send-email-chanyeol.park@samsung.com>
 <20141101212409.GA11441@t440s.P-661HNU-F1>
In-reply-to: <20141101212409.GA11441@t440s.P-661HNU-F1>
Content-type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
On 11/02/2014 06:24 AM, Johan Hedberg wrote:
> This fixed a really frequent hang for me of init HCI commands when 
> running mgmt-tester. Is it through the our user space testers that you 
> were seeing this issue as well? I might have seen the problem in the 
> past too but for some reason it started showing up really frequently 
> now. Johan 

In case of me, I've faced this bug while I execute "hciconfig hci0 down" 
and hci_dev_do_close(). and it takes about 5 second(HCI_CMD_TIMEOUT).
As you mentioned this bug is shown recently. I guess some of patches 
reveal our potential bug.

Thanks
Chanyeol



