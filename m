Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Subject: Re: MCAP Patches
Date: Fri, 23 Jul 2010 10:25:28 +0200
Cc: "Santiago Carot-Nemesio" <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <1279788733-2324-1-git-send-email-sancane@gmail.com> <20100722233606.GB2620@vigoh>
In-Reply-To: <20100722233606.GB2620@vigoh>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007231025.29101.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

El Friday 23 July 2010 01:36:06 Gustavo F. Padovan escribió:
> Hi Santiago,
> 
> * Santiago Carot-Nemesio <sancane@gmail.com> [2010-07-22 10:51:55 +0200]:
> > Hello,
> > 
> > Next you are MCAP patches that José Antonio Santos Cadenas and me have
> > generated for BlueZ. We still believe that MCAP should be an independent
> > library from HDP because other profiles non health related may want to
> > use it in the future, if we set this health dependency we will force to
> > import health features in plugins that only require MCAP. Nevertheless,
> > as we accorded last week in Brazil we are sending a last patch to set
> > MCAP into health directory with HDP. We leave in your hands upload it as
> > health plugin or not.
> 
> Please provide a git tree link for theses patches too. Thanks.

You have a copy of this changes in the follow git at branch mcap.

git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git

Regards.
