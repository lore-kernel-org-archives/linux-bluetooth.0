Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKpHsbMaQFR8X2LfKapbjUeCdppb=YkTB7UnUS6cV1-UA@mail.gmail.com>
References: <CAOASepNEyEgQaxrqN1dbmEjqVzm8+VZABt-Gcx=jBCHJ-CAM+w@mail.gmail.com>
 <CABBYNZKpHsbMaQFR8X2LfKapbjUeCdppb=YkTB7UnUS6cV1-UA@mail.gmail.com>
From: Nathaniel McCallum <npmccallum@redhat.com>
Date: Wed, 28 Feb 2018 10:39:32 -0500
Message-ID: <CAOASepP1O88T_M0v0of74PJL9WeswBGK02avs2fbQL72Dn7amw@mail.gmail.com>
Subject: Re: Clarification on Characteristic Flags
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 28, 2018 at 3:04 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Nathaniel,
>
> On Tue, Feb 27, 2018 at 7:01 PM, Nathaniel McCallum
> <npmccallum@redhat.com> wrote:
>> The documentation in doc/gatt-api.txt specifies a number of flags that
>> control the security of the operations.[0] These flags contain no
>> documentation besides a reference to the Core Bluetooth Specification.
>>
>> Unfortunately, the Core Specification has now changed and the
>> references no longer apply to the most recent documents. Further, even
>> if the references were correct, the documentation is also rather
>> opaque and presumes a lot of knowledge about Bluetooth to understand
>> the actual properties. An application developer cannot be presumed to
>> have this knowledge.
>
> The Core Specification documents Characteristic properties, and
> authentication and authorization requirements, which we combined into
> flags. The whole point is to make it trivial for the application to
> describe these requirements, but we apparently failed given your
> response.

I agree that from your perspective that makes sense. But from the
application developer perspective, they generally want to know as
little about Bluetooth as possible and just write an app that (1)
works and (2) has their desired security properties. Bluez should
provide easy to read documentation that facilitates this without
opaque references to a collection of specs.

Now, please don't take this as overly critical. In fact, I think you
have generally succeeded. I have only found the flags documentation to
be unclear.

>> Additionally, some of the flags (I think secure-read and secure-write)
>> don't appear to have any corollary in the specification. Nor is it
>> clear what behavior they actually implement.
>
> commit bf370f3bd6b00af545cb6f3d5a9b8e37a3642d3f
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Fri Apr 29 13:16:56 2016 +0300
>
>     doc/gatt-api: Add secure flags
>
>     This add secure-{read,write} which shall be used by servers that want
>     to restrict attribute access to secure connection only (BT_SECURITY_FIPS)
>
> Perhaps we should introduce a documentation about it in the doc as
> well, though this may change if SC were considered not secure anymore.

I found that commit while I was searching for meaning. For me, this
commit makes the meaning no clearer. Now, as a security guy I know
what FIPS is (I just fixed a FIPS bug in my other code this week). But
I have no idea what BT_SECURITY_FIPS actually implies and what
behaviors it enables.

>> The combination of unclear documentation and critical security
>> properties is compounded by the unclear relationship between the
>> flags. For example, how should the following three flags be used
>> together: write, authenticated-signed-writes,
>> encrypt-authenticated-write? Does this mean that the unsigned writes,
>> signed writes and signed-and-encrypted writes are allowed and any one
>> of them may be chosen (leading to potential disclosure of sensitive
>> information)? Or does it mean that writes are allowed if they are
>> signed and encrypted?
>
> Usually, you would only add one write and one read access flag, so
> with above example that would mean _any_ of the above access would be
> allowed. It most likely makes sense to be as restrictive as possible
> with flags, meaning you only add flags for the exact access type you
> need. Perhaps adding an example as such would make the documentation
> clearer?

That is what I expected to be the case. But I couldn't find any
evidence confirming this suspicion. I eventually looked at the
code.[0] This further hinted that my suspicion might be correct. But
the finer points are still unclear to me and I shouldn't have to look
at code.

>> Would it be possible to get some clear documentation on not only how
>> to use these flags but what security properties emerge from their use
>> in various combinations? I would hate for security issues to arise
>> because developers are using this API incorrectly. Thanks!
>
> Absolutely, better documentation means that we expend less time trying
> to explain aspects of the API. Btw, we also welcome contributions so
> if you have the time to a patch for the documentation it would be
> really great.

I was intending to contribute this. But I still can't make heads or
tails of the flags. I can try to write up what I understand to be the
implied behavior and submit it as a patch. But I'm sure I'll get a lot
wrong.

For example, I have a daemon[1] that runs a GATT server on my Linux
box for phones to talk to. It has a single service with a single
characteristic. The characteristic only supports write. I want to
ensure that the device can only write to this if it is (1) paired and
(2) all packets are sent with authenticated encryption. At first
glance, it seems that I want "encrypt-authenticated-write". However,
if my daemon returns this flag I am unable to make my service work
with any phone (I've tried iPhone 6+, Nexus 5x and Pixel). If I change
only that flag to "secure-write", everything seems to work with an
iPhone 6+. However, the write appears to succeed before pairing.

Because I'm lacking documentation, I'm unable to determine if that is
expected behavior or not. I can't file helpful bugs (or contribute
code) if I don't understand what the expected behavior of each flag
is.

If it would help, I will write up documentation and what I understand
to be the correct behavior for each flag. You can then correct my
errors.

[0]: https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1228
[1]: https://github.com/freeotp/jelling-linux
