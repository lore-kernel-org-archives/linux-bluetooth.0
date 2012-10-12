Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Oct 2012 17:58:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v4 1/2] rctest: add automated test
Message-ID: <20121012145858.GA19391@x220.P-661HNU-F1>
References: <1346446228-11105-1-git-send-email-gustavo@padovan.org>
 <1349668203-10782-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349668203-10782-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Oct 08, 2012, Gustavo Padovan wrote:
> adds -a option to enable automated tests. We use the -i option to define
> the receiving side and the -a define the sending side:
> 
> ./rctest -i hci0 -a hci1
> ---
>  test/rctest.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)

Both patches have been applied. Thanks.

Johan
