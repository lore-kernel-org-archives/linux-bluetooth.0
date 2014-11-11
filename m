Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Nov 2014 21:53:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/2] lib: Change bluetooth.h to compile in
 strict C
Message-ID: <20141111195302.GA13723@t440s.P-661HNU-F1>
References: <A6A9B75B-1238-4B6C-A9CD-C9E76F306DE7@holtmann.org>
 <1414515788-31370-1-git-send-email-gabrielfrancosouza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414515788-31370-1-git-send-email-gabrielfrancosouza@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gabriel,

On Tue, Oct 28, 2014, Gabriel Souza Franco wrote:
> ---
> 
> This change enables programs writen with strict C syntax
> (e.g. "-std=c11 -pedantic") to compile when including
> bluetooth.h.
> 
> v2: Resend with fixed commits.
> 
>  lib/bluetooth.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Both of these patches have been applied. Thanks.

Johan
