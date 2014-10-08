Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
Date: Wed, 8 Oct 2014 13:38:53 +0300
Message-ID: <CABBYNZ+GQ7ffqVnpTKVBZ02_5bqQoPhjz7Ue+ELpfCKGLZF0kg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for MAP MASInstance feature
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 7, 2014 at 7:06 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> This patch-set implements MAP 1.2 MAS Instance feature.
>
> The patch 1,2,3 will handle the Client part(MCE). It passes
> the PTS 5.3 test case:TC_MCE_MMI_BV_01_I.
>
> The patch 4,5,6 will handle the Server part(MSE). It passes
> the PTS 5.3 test case:TC_MSE_MMI_BV_02_I.
>
> Gowtham Anandha Babu (6):
>   doc/obex-api: Add description about MASInstance request
>   test/map-client: Add D-Bus API support to make MASInstance request
>   obexd/client/map: Add API Calls for request and handlers for response
>   obexd/mas: Add support for providing MASInstance Info as response
>   obexd/messages: Add prototypes for MASInstance response
>   obexd/message-dummy: Add MAS Instance description to response
>
>  doc/obex-api.txt               |  6 +++
>  obexd/client/map.c             | 88 ++++++++++++++++++++++++++++++++++++++++++
>  obexd/plugins/mas.c            | 62 +++++++++++++++++++++++++++++
>  obexd/plugins/messages-dummy.c | 18 +++++++++
>  obexd/plugins/messages.h       | 16 ++++++++
>  test/map-client                |  9 +++++
>  6 files changed, 199 insertions(+)
>
> --
> 1.9.1

My plan is to actually do this as the name of the folder for each instance:

<MAS 1 info>/telecom/...
<MAS 2 info>/telecom/...

If there is no info, due to version or lack of support, then we
fallback to record description or something like that so we can
support multiple instances.


-- 
Luiz Augusto von Dentz
