Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Drop Posix Capabilities
From: Marcel Holtmann <marcel@holtmann.org>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200909251647.15440.sgrubb@redhat.com>
References: <200909251647.15440.sgrubb@redhat.com>
Content-Type: text/plain
Date: Fri, 02 Oct 2009 11:46:51 +0200
Message-Id: <1254476811.20362.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

> The following patch against the 4.54 codebase drops posix capabilities
> after startup so that the bluetooth daemon is less of a threat to the
> system should there be any way to compromise it. The retained 
> capabilities was compared to selinux policy to make sure that its 
> roughly the same. It uses the libcap-ng library which allows patches
> for dropping capabilities to be much smaller.

so I went through the patch and applied it with using pkg-config
support. So if you would update libcap-ng in Fedora 11, I would be able
to test it. Otherwise it has to wait until I actually switch to the next
release ;)

Regards

Marcel


