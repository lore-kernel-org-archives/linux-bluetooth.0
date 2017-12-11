Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 11 Dec 2017 11:20:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] mesh: Fix crash while reading input parameters
Message-ID: <20171211092028.GA802@x1c>
References: <20171208171230.11069-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208171230.11069-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Dec 08, 2017, Luiz Augusto von Dentz wrote:
> read_input_parameters skips the command argument thus arg[0] shall be
> considerer the fist argument.
> ---
>  mesh/config-client.c | 5 ++++-
>  mesh/onoff-model.c   | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
