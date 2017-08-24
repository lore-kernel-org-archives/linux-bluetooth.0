Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170824070319.GA31562@bla.fasel.org>
References: <20170824070319.GA31562@bla.fasel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Aug 2017 17:30:05 +0300
Message-ID: <CABBYNZLsNq5xXErq46nY5D8xBhXNfZH19xFjJjH0FDkTFkkUvw@mail.gmail.com>
Subject: Re: files missing in release tarball (esp. profiles/proximity/*)
To: Wolfram Schlich <wschlich@gentoo.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wolfram,

On Thu, Aug 24, 2017 at 10:03 AM, Wolfram Schlich <wschlich@gentoo.org> wrote:
> Hi,
>
> there seem to be quite some differences between the git snapshot
> tarball[1] and the release tarball[2]:
>
> 1. https://git.kernel.org/pub/scm/bluetooth/bluez.git/snapshot/bluez-5.46.tar.gz
> 2. https://www.kernel.org/pub/linux/bluetooth/bluez-5.46.tar.gz
>
> A diff -ur between both unpacked tarballs shows:
> --8<--
> Only in bluez-5.46-release-tarball: aclocal.m4
> Only in bluez-5.46-git-snapshot-tarball/android: sco-ipc-api.txt
> Only in bluez-5.46-git-snapshot-tarball/android: socket-api.txt
> Only in bluez-5.46-git-snapshot-tarball: bootstrap
> Only in bluez-5.46-git-snapshot-tarball: bootstrap-configure
> Only in bluez-5.46-release-tarball: compile
> Only in bluez-5.46-release-tarball: config.guess
> Only in bluez-5.46-release-tarball: config.h.in
> Only in bluez-5.46-release-tarball: config.sub
> Only in bluez-5.46-release-tarball: configure
> Only in bluez-5.46-release-tarball: depcomp
> Only in bluez-5.46-git-snapshot-tarball/doc: coding-style.txt
> Only in bluez-5.46-git-snapshot-tarball/doc: maintainer-guidelines.txt
> Only in bluez-5.46-git-snapshot-tarball: .gitignore
> Only in bluez-5.46-git-snapshot-tarball: HACKING
> Only in bluez-5.46-release-tarball: install-sh
> Only in bluez-5.46-release-tarball: ltmain.sh
> Only in bluez-5.46-git-snapshot-tarball: .mailmap
> Only in bluez-5.46-release-tarball: Makefile.in
> Only in bluez-5.46-release-tarball: missing
> Only in bluez-5.46-git-snapshot-tarball/obexd/plugins: messages-tracker.c
> Only in bluez-5.46-git-snapshot-tarball/obexd/plugins: phonebook-ebook.c
> Only in bluez-5.46-git-snapshot-tarball/obexd/plugins: phonebook-tracker.c
> Only in bluez-5.46-git-snapshot-tarball/obexd/plugins: syncevolution.c
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: immalert.c
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: immalert.h
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: linkloss.c
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: linkloss.h
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: main.c
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: manager.c
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: manager.h
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: monitor.c
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: monitor.h
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: reporter.c
> Only in bluez-5.46-git-snapshot-tarball/profiles/proximity: reporter.h
> Only in bluez-5.46-git-snapshot-tarball/test: exchange-business-cards
> Only in bluez-5.46-git-snapshot-tarball/test: get-managed-objects
> Only in bluez-5.46-git-snapshot-tarball/test: get-obex-capabilities
> Only in bluez-5.46-git-snapshot-tarball/test: list-folders
> Only in bluez-5.46-git-snapshot-tarball/test: simple-obex-agent
> Only in bluez-5.46-release-tarball: test-driver
> Only in bluez-5.46-git-snapshot-tarball/tools: example.psr
> Only in bluez-5.46-git-snapshot-tarball/tools: parse_companies.pl
> Only in bluez-5.46-git-snapshot-tarball/tools: update_compids.sh
> Only in bluez-5.46-git-snapshot-tarball/tools: valgrind.supp
> --8<--
>
> Notably the files from obexd/plugins/, profiles/proximity/
> and test/ are missing in the release tarball.
>
> The program 'bluez-test-proximity' is, for example, effectively
> unusable when using the release tarball because of the missing
> files from profiles/proximity/:
> --8<--
> zephyr ~ # /usr/bin/bluez-test-proximity -b AA:BB:CC:DD:EE:FF LinkLossAlertLevel high
> Proximity SetProperty('LinkLossAlertLevel', 'high')
> Traceback (most recent call last):
>   File "/usr/bin/bluez-test-proximity", line 67, in <module>
>     device_prop.Set(PROXIMITY_MONITOR_INTERFACE, args[0], args[1])
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 70, in __call__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 145, in __call__
>     **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line 651, in call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: org.freedesktop.DBus.Error.InvalidArgs: No such interface 'org.bluez.ProximityMonitor1'
> zephyr ~ #
> --8<--
>
> Can you fix this (at least profiles/proximity/), please?

The proximity profile is no longer build-in as we these profiles
should be implemented using the GATT D-Bus API, the files under
profiles/proximity are a left over of the cleanup and I will probably
remove them along with documentation and the test script. We may as
well add a sample application using the D-Bus apply to do the same as
the plugins was doing.

> Thank you!
>
> Cheers,
> Wolfram
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
