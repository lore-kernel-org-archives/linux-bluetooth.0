Return-Path: <cyrus@holtmann.org>
From: Denis Kenzior <denis.kenzior@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Fix introspection issue in gdbus
Date: Mon, 11 May 2009 13:45:49 -0500
References: <79DD16001F75DB4EB7DE37CDD687BB2001B7238D@dalamsexb02.AMERICAS.ROOT.PRI> <20090507212508.GA23276@jh-x301>  <79DD16001F75DB4EB7DE37CDD687BB2001B723C4@dalamsexb02.AMERICAS.ROOT.PRI>
In-Reply-To: <79DD16001F75DB4EB7DE37CDD687BB2001B723C4@dalamsexb02.AMERICAS.ROOT.PRI>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eJHCK7OzYiVSV/N"
Message-Id: <200905111345.50534.denis.kenzior@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_eJHCK7OzYiVSV/N
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Attached is a patch to fix a small issue with introspection when using gdbus 
library.  Basically the introspection data for '/' can never be invalidated, 
which leads to funny results when objects are added & removed from '/' 
hierarchy.

Attached patch should fix the issue.

Regards,
-Denis

--Boundary-00=_eJHCK7OzYiVSV/N
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Make-the-parent-path-invalidateable.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Make-the-parent-path-invalidateable.patch"

=46rom 3cd7a2c3483ceac8950c32d0c96786b15e05946f Mon Sep 17 00:00:00 2001
=46rom: Denis Kenzior <denis.kenzior@intel.com>
Date: Wed, 1 Apr 2009 16:56:53 -0500
Subject: [PATCH] Make the parent path invalidateable

=2D--
 gdbus/object.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2823054..3186921 100644
=2D-- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -307,7 +307,11 @@ static void invalidate_parent_data(DBusConnection *con=
n, const char *child_path)
 	if (!slash)
 		goto done;
=20
=2D	*slash =3D '\0';
+	if (slash =3D=3D parent_path && parent_path[1] !=3D '\0')
+		parent_path[1] =3D '\0';
+	else
+		*slash =3D '\0';
+
 	if (!strlen(parent_path))
 		goto done;
=20
=2D-=20
1.6.0.6


--Boundary-00=_eJHCK7OzYiVSV/N--
