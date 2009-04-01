Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Fix null dereference in gdbus/watch.c
Date: Tue, 31 Mar 2009 23:30:44 -0300
Message-Id: <1238553045-23938-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1238553045-23938-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1238553045-23938-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If name or data->name is null we have a null dereference. Not name and
data->name.
---
 gdbus/watch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 38bf3d7..607803c 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -62,7 +62,7 @@ static struct name_data *name_data_find(DBusConnection *connection,
 			current != NULL; current = current->next) {
 		struct name_data *data = current->data;
 
-		if (name == NULL && data->name == NULL) {
+		if (name == NULL || data->name == NULL) {
 			if (connection == data->connection)
 				return data;
 		} else {
-- 
1.6.0.6

