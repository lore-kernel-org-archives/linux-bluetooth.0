Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B9402F9A-9F2F-4C2B-8F54-24DD213A167A@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
In-Reply-To: <35c90d960901261529i699411a7jddb81b8d9bef74f8@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: duplicate L2CAP connection requests - before and after L2CAP  information response
Date: Tue, 27 Jan 2009 02:17:52 +0100
References: <35c90d960901261529i699411a7jddb81b8d9bef74f8@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> We've noticed In some situations Bluez will send duplicate L2CAP
> connection requests.
> - Both are due to the same userspace connect() call, and have the same
> PSM and SCID, but different identifier. So the remote stack cannot
> send duplicate response because of different identifiers.
> - The first occurs before receiving L2CAP info response, and the
> second after due to the l2cap_information_rsp() -> l2cap_conn_start()
> code path.
>
> We are able to reproduce this consistently with basically any A2DP PTS
> test case. It only happens when the test case is started when already
> paired. This causes the PTS test case to fail because the tester
> rejects the second L2CAP request (resource unavailable).
>
> We are using 2.6.27. I looked at l2cap.c in bluetooth-testing.git and
> believe it will have the same issue.
>
> Question: to fix, which connection request should be removed?

can you write a small test case for this or use l2test to reproduce  
it. If so, then I might be able to fix this quickly. I have currently  
no clue why this happens and funny part of that is that we did pass  
all the BITE test cases ;)

Regards

Marcel

