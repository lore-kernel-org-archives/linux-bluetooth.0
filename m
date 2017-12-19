Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1513672910.12400.17.camel@cortland.com>
Subject: Re: [PATCH BlueZ] mesh:meshctl: make model parsing more manageable
From: Steve Brown <sbrown@cortland.com>
To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org
Date: Tue, 19 Dec 2017 03:41:50 -0500
In-Reply-To: <20171218203551.6142-1-inga.stotland@intel.com>
References: <20171218203551.6142-1-inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Mon, 2017-12-18 at 12:35 -0800, Inga Stotland wrote:
> Extract functionality for finding an existing model from
> parse_configuration_models() into new function
> find_configured_model().
> This removes confusing logic from overloaded implementation of
> parse_configuration_models().
> ---
>  mesh/prov-db.c | 54 ++++++++++++++++++++++++++++++++++++++++++----
> --------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/mesh/prov-db.c b/mesh/prov-db.c
> index 04803a5c8..8a7b47f6e 100644
> --- a/mesh/prov-db.c
> +++ b/mesh/prov-db.c
> @@ -371,14 +371,49 @@ static bool parse_bindings(struct mesh_node
> *node, int ele_idx,
>  	return true;
>  }
>  
> -static bool parse_configuration_models(struct mesh_node *node, int
> ele_idx,
> -		json_object *jmodels, uint32_t target_id,
> json_object **jtarget)
> +static json_object* find_configured_model(struct mesh_node *node,
> int ele_idx,
> +				       json_object *jmodels,
> uint32_t target_id)
>  {
>  	int model_cnt;
>  	int i;
>  
> -	if (jtarget)
> -		*jtarget = NULL;
> +	model_cnt = json_object_array_length(jmodels);
> +
> +	for (i = 0; i < model_cnt; ++i) {
> +		json_object *jmodel;
> +		json_object *jvalue;
> +		char *str;
> +		int len;
> +		uint32_t model_id;
> +
> +		jmodel = json_object_array_get_idx(jmodels, i);
> +
> +		json_object_object_get_ex(jmodel, "modelId",
> &jvalue);
> +		str = (char *)json_object_get_string(jvalue);
> +
> +		len = strlen(str);
> +
> +		if (len != 4 && len != 8)
> +			return NULL;
> +
> +		if (sscanf(str, "%08x", &model_id) != 1)
> +			return NULL;
> +
> +		if (len == 4)
> +			model_id += 0xffff0000;
> +
> +		if (model_id == target_id)
> +			return jmodel;
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool parse_configuration_models(struct mesh_node *node, int
> ele_idx,
> +							json_object
> *jmodels)
> +{
> +	int model_cnt;
> +	int i;
>  
>  	model_cnt = json_object_array_length(jmodels);
>  
> @@ -405,11 +440,6 @@ static bool parse_configuration_models(struct
> mesh_node *node, int ele_idx,
>  		if (len == 4)
>  			model_id += 0xffff0000;
>  
> -		if (jtarget && model_id == target_id) {
> -			*jtarget = jmodel;
> -			return true;
> -		}
> -
>  		json_object_object_get_ex(jmodel, "bind", &jarray);
>  		if (jarray && !parse_bindings(node, ele_idx,
> model_id, jarray))
>  			return false;
> @@ -468,7 +498,7 @@ static bool parse_configuration_elements(struct
> mesh_node *node,
>  		if (!jmodels)
>  			continue;
>  
> -		if(!parse_configuration_models(node, index, jmodels,
> 0, NULL))
> +		if(!parse_configuration_models(node, index,
> jmodels))
>  			return false;
>  	}
>  	return true;
> @@ -1011,8 +1041,8 @@ static json_object *get_jmodel_obj(struct
> mesh_node *node, uint8_t ele_idx,
>  		jmodels = json_object_new_array();
>  		json_object_object_add(jelement, "models", jmodels);
>  	} else {
> -		parse_configuration_models(node, ele_idx, jmodels,
> -							model_id,
> &jmodel);
> +		jmodel = find_configured_model(node, ele_idx,
> jmodels,
> +								mode
> l_id);
>  	}
>  
>  	if (!jmodel) {

This patch also solves the problem of duplicate modelId objects being
inserted in the json database for other than the primary element of a
multi-element node.

Steve

