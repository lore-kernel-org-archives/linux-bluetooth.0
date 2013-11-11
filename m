Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1381862383-9866-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1381777790-28891-1-git-send-email-claudio.takahasi@openbossa.org>
	<1381862383-9866-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Mon, 11 Nov 2013 10:56:22 -0800
Message-ID: <CAHZ1yCmTdG_ynyfXj0CYhRsPWdM5MBeySvG1Wd5Xb+nEvCVH0A@mail.gmail.com>
Subject: Re: [RFC BlueZ v1] doc: Add GATT API
From: Scott James Remnant <keybuk@google.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 15, 2013 at 11:39 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:

> +GATT local and remote services share the same high-level D-Bus API. Local
> +refers to local GATT based service exported by a BlueZ plugin or an external
> +application. Remote refers to GATT services exported by the peer.

If this object format also be used to describe the services and
characteristics of a remote device, how will those be handled? I
assume that we don't want to get the value of every single
characteristic on connection - that seems wasteful, and would quite
rapidly drain the batteries of smaller devices.


How will service changed be handled? How will BlueZ track the set of
applications, and the set of services etc. defined by those
applications in a manner that keeps handles consistent? How will it
handle generating the Services Changed notification in the cases where
the set of applications and/or services change, or the handles change?


> +Characteristic hierarchy
> +========================
  :
> +Service                org.bluez
> +Interface      org.bluez.Characteristic1 [Experimental]
> +Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY

This would also need a "Permissions" property akin to the one you have
for Descriptors - characteristics can be "not accessible", read-only,
write-only, read/write - and can also require authorization,
authentication, encryption and minimum encryption key sizes - as with
descriptors.

> +               array{byte} Value [read-write]
> +
> +                       Cached Value of the characteristic. If present, the
> +                       value will be cached by bluetoothd and updated when the
> +                       PropertiesChanged signal is emitted.
> +
> +                       External services must emit this signal when the
> +                       characteristic supports notification/indication, so
> +                       that clients can be notified of the new value.

The PropertiesChanged signal explains how Notification will be handled
- but how will Indication? How will a service receive the Indication
Confirmation from the remote devices?


> +Application Manager hierarchy
> +=============================
  :
> +Service                org.bluez
> +Interface      org.bluez.ApplicationManager1 [Experimental]
> +Object path    /org/bluez
> +
> +Methods                RegisterAgent(object application, dict options)

Shouldn't this be "RegisterApplication" ?

I assume that the object path is the one to which D-Bus Object Manager
queries are sent, allowing a single process to implement multiple
"applications"?

> +               UnregisterAgent(object application)

Likewise, "UnregisterApplication" ?

> +Application Agent hierarchy
> +===========================
> +
> +Service                unique name
> +Interface      org.bluez.ApplicationAgent1 [Experimental]
> +Object path    freely definable
> +

"Agent" seems unnnecessary here - if the object is an Application,
then org.bluez.Application1 would be a decent enough name. Thus an
"Application" consists of multiple Services, each of which consists of
multiple Characteristics, each of which has multiple Descriptors

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
