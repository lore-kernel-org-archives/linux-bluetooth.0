Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Mar 2011 15:13:46 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Fix the behaviour of the Attribute API Discover
 method
Message-ID: <20110314181345.GA14234@piper>
References: <1299865982-13601-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299865982-13601-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 14:52 Fri 11 Mar, Vinicius Costa Gomes wrote:
> This method returns as soons as all the characteristics
> are discovered or a error happens. The old behaviour was
> to return as soon as the connection was made.
> 
> Now it is safe to call GetCharacteristics() as soon as this
> method returns sucessfully.
> 
> After this method returns it will try to read all the characteristics
> values.
> ---
>  attrib/client.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 

[ ... ]

Please disconsider this patch series. Will send another one soon.


Cheers,
-- 
Vinicius
