Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [RFC 2/3] mgmt-api: Add Stop Read Remote RSSI Command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395954629-16156-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 28 Mar 2014 00:13:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <090A8293-5C1D-458E-BC16-F4553C14894F@holtmann.org>
References: <1395954629-16156-1-git-send-email-lukasz.rymanowski@tieto.com> <1395954629-16156-2-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> ---
> doc/mgmt-api.txt | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 28e7845..6d3b86b 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1700,6 +1700,27 @@ Start Read Remote RSSI Command
> 				Invalid Index

you really want to send all the mgmt-api changes in one patch to make them easier to review and comment on.

Regards

Marcel

