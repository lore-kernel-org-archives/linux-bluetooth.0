Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Don Zickus <dzickus@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Debugging bluetoothd, dbus and selinux help?
Date: Fri, 17 Jun 2016 10:32:23 +0200
Message-ID: <14376099.m2jF0XBNfH@ix>
In-Reply-To: <20160615170025.GB90326@redhat.com>
References: <20160615170025.GB90326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wednesday 15 June 2016 13:00:25 Don Zickus wrote:
> Hi,
> 
> I am trying to debug why bluetoothd decides to disconnect from the d-bus on
> the host, when the client does an object push to an obex agent on the host.
> 
> When I set selinux to permissive mode ('setenforce 0'), things work fine (ie
> the object push goes through).
> 
> I tried searching /var/log/audit/audit.log, journalctl and dbus-monitor for
> clues (on the host) and can't find anything obvious.
> 
> Does anyone have any tips on how to find what security policy might be
> interfering with my test?
> 

To me it looks like FD passing on D-Bus is being blocked by SELinux.

-- 
pozdrawiam
Szymon Janc
