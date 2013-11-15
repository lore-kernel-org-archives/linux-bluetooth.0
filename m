Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH 1/2] android: Add PTS PICS for GAP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1384435587-12427-1-git-send-email-jakub.tyszkowski@tieto.com>
Date: Fri, 15 Nov 2013 09:51:37 +0900
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <DE4A3DEB-E974-4CBD-BA6E-0740A42F71C1@holtmann.org>
References: <1384435587-12427-1-git-send-email-jakub.tyszkowski@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> PTS PICS for GAP, targeting Android 4.4.
> 
> ---
> android/pics-gap.txt | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 201 insertions(+)
> create mode 100644 android/pics-gap.txt
> 
> diff --git a/android/pics-gap.txt b/android/pics-gap.txt
> new file mode 100644
> index 0000000..bcb64cb
> --- /dev/null
> +++ b/android/pics-gap.txt
> @@ -0,0 +1,201 @@
> +GAP PICS for the PTS tool.
> +
> +* - different than PTS defaults
> +
> ++------------------+------------+
> +|  Parameter Name  |  Selected  |
> ++------------------+------------+
> +| TSPC_GAP_0_1     |   False    |
> +| TSPC_GAP_0_2     |   False    |
> +| TSPC_GAP_0_3     |   True*    |

I would go easy on the ASCII Art here. A simple table with tabs should be just fine.

Parameter name		Selected	Description
-------------------------------------------------------------
TSPC_GAP_0_1		True (*)	Short description of what it is

Regards

Marcel

