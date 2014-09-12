Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410252258-26093-1-git-send-email-luiz.dentz@gmail.com>
References: <1410252258-26093-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 12 Sep 2014 15:47:31 +0300
Message-ID: <CABBYNZJh1MY8_YMTCqGh+DTHZ=PYGh5XViAo8ougn0-_+n8bbg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/obex-api: Add API for PBAP 1.2 features
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 9, 2014 at 11:44 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> These changes add support for PBAP 1.2 features, the idea is that upon
> connecting the stack will auto retrieve the DatabaseIdentifier which will
> very likely be used by applications to detect if anything should be done.
>
> In case DatabaseIdentifier is present the user application can then
> request the folder version via GetVersion.
>
> Two new filter are added, Operator which should be used along with FilterBy
> and ResetNewMissedCalls the later can only be used in mch and cch folders.
> ---
>  doc/obex-api.txt | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index 9542a30..f31d742 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -431,6 +431,14 @@ Methods            void Select(string location, string phonebook)
>                         Possible errors: org.bluez.obex.Error.Forbidden
>                                          org.bluez.obex.Error.Failed
>
> +               uint16, uint16 GetVersion()
> +
> +                       Return the primary and secondy folder version counters
> +                       for the selected phonebook.
> +
> +                       Possible errors: org.bluez.obex.Error.Forbidden
> +                                        org.bluez.obex.Error.Failed
> +
>                 array{string} ListFilterFields()
>
>                         Return All Available fields that can be used in Fields
> @@ -465,6 +473,30 @@ Filter:            string Format:
>
>                         Possible values can be query with ListFilterFields.
>
> +               array{string} FilterBy:
> +
> +                       Filter items by fields. Default do not filter by
> +                       fields.
> +
> +                       Possible values can be query with ListFilterFields
> +                       excluding the first item that must be either '&' or
> +                       '|' that apply AND or OR logic respectively.
> +
> +               bool ResetNewMissedCalls
> +
> +                       Reset new the missed calls items, shall only be used
> +                       for folders mch and cch.
> +
> +Properties     string Folder [readonly]
> +
> +                       Current folder.
> +
> +               string DatabaseIdentifier [readonly]
> +
> +                       128 bits persistent identifier.
> +
> +                       Value '0' shall be considered as not supported.
> +
>
>  Synchronization hierarchy
>  =========================
> --
> 1.9.3

Applied.


-- 
Luiz Augusto von Dentz
