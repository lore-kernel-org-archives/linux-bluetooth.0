Return-Path: <cyrus@holtmann.org>
Message-ID: <492E6E6A.80509@koala.ie>
Date: Thu, 27 Nov 2008 09:54:50 +0000
From: Simon Kenyon <simon@koala.ie>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Sony BD Remote (help requested)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

i'm trying to get y BD Remote to work.

this is what i have done so far:

installed bluez from git (as of yesterday)
configured it (i think)
when i:

hidd --search

i see the remote

by using udev rules i create /dev/bdremote (which links to 
/dev/input/event<x>, for the correct <x>)
i can see the key presses on the remote being transmitted (using hcidump)

what i cannot do see is ny events occuring (by loading evbug)
i'm trying to get the events into lirc

i promise to write up the steps if i get it working

i'm running a pretty standard gentoo setup with kde (not gnome)

any help would be appreciated
--
simon

