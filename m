Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415782897-11667-1-git-send-email-gowtham.ab@samsung.com>
References: <1415782897-11667-1-git-send-email-gowtham.ab@samsung.com>
Date: Wed, 12 Nov 2014 17:15:37 +0200
Message-ID: <CABBYNZKxBr4p3wwVdkdUD=c6qDY+mR8ozW4TNq1NZM+z3knaqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] src/profile: Add pbapsupportedfeatures to PSE
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Wed, Nov 12, 2014 at 11:01 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Add PbapSupportedFeatures(0x0317) to PSE Record.
>
> PTS Test case passed:
> TP/SSM/BV-11-C [PSE Shares PbapSupportedFeatures bits].
> ---
>  src/profile.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/profile.c b/src/profile.c
> index bccb145..252063b 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -393,6 +393,9 @@
>                 <attribute id=\"0x0314\">                               \
>                         <uint8 value=\"0x01\"/>                         \
>                 </attribute>                                            \
> +               <attribute id=\"0x0317\">                               \
> +                       <uint32 value=\"0x00000003\"/>                  \
> +               </attribute>                                            \
>         </record>"
>
>  #define MAS_RECORD                                                     \
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
