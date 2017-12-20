Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1513767640.4409.86.camel@cortland.com>
Subject: Re-provisioning & Re-configuring a node
From: Steve Brown <sbrown@cortland.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 20 Dec 2017 06:00:40 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, if a node's uuid is already known to meshctl, an attempt to
provision it results in the error "Already provisioned."

I'd like to solicit comments on whether it would be useful to restore
the prior provisioning (primary unicast address and keys) and
configuration of a known unprovisioned node instead of considering it
an error.

The motivation is to minimize the number of meshctl commands that have
to be input to provision and configure a mesh after a power cycle or
firmware flash. For example, it takes 2 commands to minimally configure
an element and another 2 commands to configure each of its models. Each
node of the 52840 onoff sample has 4 elements each with 2 models. 
That's 24 commands per node. A minimal mesh of three of these would
require the accurate typing of over 70 commands to get it back to where
it was.

This isn't meant as an alternative to persistent storage of
configuration and state in a node, rather an aid in prototyping or
developing an application.

Steve






