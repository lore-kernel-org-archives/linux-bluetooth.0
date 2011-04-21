Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Content-Type: text/plain; charset=us-ascii
Subject: Announcement: Antidote, an IEEE 11073 library
Date: Wed, 20 Apr 2011 22:09:52 -0300
Message-Id: <A3EC7A9A-8F49-4E71-8927-3B251AFD6A1B@signove.com>
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1084)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the time we worked on BlueZ HDP support, we missed a free implementation
for the "upper part" of health protocol stack, namely the IEEE 11073-20601
standard.

Well, not anymore. Signove has released its implementation as free software:

http://oss.signove.com/index.php/Antidote_release_announcement

Antidote contains:

1) a library that can be statically or dynamically liked by any application that
needs to use the IEEE protocol;

2) a set of transport plug-ins that save the core library from most platform
dependencies. The most well-tested, by now, is the BlueZ HDP plugin. (Currently,
plug-ins are linked along with library.)

3) a sample health D-Bus service that allows applications to communicate with
health devices without having to link with Antidote library. This service is
perfectly functional and doubles as a complete example of how to use the
Antidote API.

License is LGPL.