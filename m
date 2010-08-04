Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Changes in HDP API 
Date: Wed,  4 Aug 2010 09:49:11 +0200
Message-Id: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes some changes in the HDP API based in the conversation that I
had yesterday with Luiz and Elvis.

I still have a doubt about the notification of devices in the agent. Luiz
commented that with this API the Agent and the Application could not be in
different processes, is this a problem?

An other open issue is: if we notify when a device is discovered and suitable
for connect with an application and when a devices is removed (or becomes not
suitable for connect). I think that we already need something like the patch
that we start discussing yesterday, something that can be called by the user
in order to force a new service discovery and notifies the driver that will
notify the agent. Of course we can avoid this not notifying the suitable
devices and just letting to try the connection against all the devices (if
there is no matching service it will fail). What do you think?

Regards.

Jose.

