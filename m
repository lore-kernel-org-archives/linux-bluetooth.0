Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1423760408-31020-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423760408-31020-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 13 Feb 2015 14:54:26 +0200
Message-ID: <CABBYNZKSGWog=Su2YZBU0h5LhPutEe28dbmn1vbL3Jw2Bb7EFQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] shared/att: Add support to set security in LE link
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Feb 12, 2015 at 7:00 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> It shall be possible to set security on the link once there is
> such a requirement from remote server database.
>
> Also as a server we should be able to get security level to determine
> access to characteristics for remote client.
>
> Those patches adds support to set/get security level.
>
> Those patches are required in order to make Android code to use
> shared/gatt-client
>
> Note that if io is not L2CAP (e.g. unit test), set security level will always
> succeed and get will always return BT_SECURITY_LOW for now.
>
>
> Lukasz Rymanowski (3):
>   shared/att: Add set/get security level
>   shared/gatt-client: Expose API to set/get security level on att
>   tools/btgatt-client: Add support for set/get security on the link
>
>  src/shared/att.c         | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/att.h         |  3 ++
>  src/shared/gatt-client.c | 17 ++++++++++++
>  src/shared/gatt-client.h |  3 ++
>  tools/btgatt-client.c    | 64 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 159 insertions(+)
>
> --
> 1.8.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
