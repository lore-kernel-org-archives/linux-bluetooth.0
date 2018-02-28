Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOASepNEyEgQaxrqN1dbmEjqVzm8+VZABt-Gcx=jBCHJ-CAM+w@mail.gmail.com>
References: <CAOASepNEyEgQaxrqN1dbmEjqVzm8+VZABt-Gcx=jBCHJ-CAM+w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Feb 2018 10:04:00 +0200
Message-ID: <CABBYNZKpHsbMaQFR8X2LfKapbjUeCdppb=YkTB7UnUS6cV1-UA@mail.gmail.com>
Subject: Re: Clarification on Characteristic Flags
To: Nathaniel McCallum <npmccallum@redhat.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathaniel,

On Tue, Feb 27, 2018 at 7:01 PM, Nathaniel McCallum
<npmccallum@redhat.com> wrote:
> The documentation in doc/gatt-api.txt specifies a number of flags that
> control the security of the operations.[0] These flags contain no
> documentation besides a reference to the Core Bluetooth Specification.
>
> Unfortunately, the Core Specification has now changed and the
> references no longer apply to the most recent documents. Further, even
> if the references were correct, the documentation is also rather
> opaque and presumes a lot of knowledge about Bluetooth to understand
> the actual properties. An application developer cannot be presumed to
> have this knowledge.

The Core Specification documents Characteristic properties, and
authentication and authorization requirements, which we combined into
flags. The whole point is to make it trivial for the application to
describe these requirements, but we apparently failed given your
response.

> Additionally, some of the flags (I think secure-read and secure-write)
> don't appear to have any corollary in the specification. Nor is it
> clear what behavior they actually implement.

commit bf370f3bd6b00af545cb6f3d5a9b8e37a3642d3f
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Apr 29 13:16:56 2016 +0300

    doc/gatt-api: Add secure flags

    This add secure-{read,write} which shall be used by servers that want
    to restrict attribute access to secure connection only (BT_SECURITY_FIPS)

Perhaps we should introduce a documentation about it in the doc as
well, though this may change if SC were considered not secure anymore.

> The combination of unclear documentation and critical security
> properties is compounded by the unclear relationship between the
> flags. For example, how should the following three flags be used
> together: write, authenticated-signed-writes,
> encrypt-authenticated-write? Does this mean that the unsigned writes,
> signed writes and signed-and-encrypted writes are allowed and any one
> of them may be chosen (leading to potential disclosure of sensitive
> information)? Or does it mean that writes are allowed if they are
> signed and encrypted?

Usually, you would only add one write and one read access flag, so
with above example that would mean _any_ of the above access would be
allowed. It most likely makes sense to be as restrictive as possible
with flags, meaning you only add flags for the exact access type you
need. Perhaps adding an example as such would make the documentation
clearer?

> Would it be possible to get some clear documentation on not only how
> to use these flags but what security properties emerge from their use
> in various combinations? I would hate for security issues to arise
> because developers are using this API incorrectly. Thanks!

Absolutely, better documentation means that we expend less time trying
to explain aspects of the API. Btw, we also welcome contributions so
if you have the time to a patch for the documentation it would be
really great.

> [0]: https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n227
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
