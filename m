Return-Path: <cyrus@holtmann.org>
Message-ID: <1352457867.16204.9.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/2] build: Require D-Bus 1.5 or later
From: Marcel Holtmann <marcel@holtmann.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 09 Nov 2012 11:44:27 +0100
In-Reply-To: <1352449889-5149-1-git-send-email-s.syam@samsung.com>
References: <1352449889-5149-1-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> The gdbus require D-Bus 1.5 version.
> 
> Log:
>   CC     gdbus/object.o
> gdbus/object.c: In function ‘properties_set’:
> gdbus/object.c:876:7: error: ‘DBUS_ERROR_UNKNOWN_PROPERTY’ undeclared
>  (first use in this function)
> gdbus/object.c:876:7: note: each undeclared identifier is reported
>  only once for each function it appears in
> gdbus/object.c:881:6: error: ‘DBUS_ERROR_PROPERTY_READ_ONLY’
>  undeclared (first use in this function)
> make[1]: *** [gdbus/object.o] Error 1
> make: *** [all] Error 2

if they are still simple defines, then lets just #ifndef them and define
them in gdbus/object.c

Regards

Marcel


