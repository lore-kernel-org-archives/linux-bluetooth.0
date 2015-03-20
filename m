Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
References: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
Date: Fri, 20 Mar 2015 12:27:52 +0200
Message-ID: <CABBYNZKZVqdR2zWUY398RbCj_SiQ0Siq2BfCjHpXa0afe_j5yQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add Reliable Writes Server test cases
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Wed, Mar 18, 2015 at 12:05 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Adds the below server test cases (tested against small and large DB):
> 1) Characteristic Value Reliable Writes - to Server
> 2) Nested Long Characteristic Value Reliable Writes - to Server
> 3) Characteristic Value Reliable Writes - Invalid Handle Response
> 4) Characteristic Value Reliable Writes - Write Not Permitted Response
> 5) Cancel Reliable Write Characteristic – from Server
>
> Tested using valgrind, no regression/core dump found.
>
> Gowtham Anandha Babu (7):
>   unit/test-gatt: Add TP/GAW/SR/BV-06-C test
>   unit/test-gatt: Add TP/GAW/SR/BV-10-C test
>   unit/test-gatt: Add TP/GAW/SR/BI-14-C test
>   unit/test-gatt: Add TP/GAW/SR/BI-15-C test
>   unit/test-gatt: Add TP/GAW/SR/BV-07-C test
>   doc/test-coverage: Update test-gatt count
>   shared/tester: Fix divide by zero error
>
>  doc/test-coverage.txt |  4 +--
>  src/shared/tester.c   |  3 +-
>  unit/test-gatt.c      | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 95 insertions(+), 4 deletions(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
